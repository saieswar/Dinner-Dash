class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception
  helper_method :current_user
  helper_method :get_cart
 #before_filter :cart_array
  private 

    def current_user
   	  User.find(session[:user_id]) if session[:user_id].present?
    end

    def get_cart
      Order.find(session[:cart]) if session[:cart].present?
    end

  public

    def close_app
      if session[:cart] == {} && current_user.present? == false
        puts "------------------------------------------"
      end
        
    end

    def cart_items
      session[:cart]=Order.create.id unless session[:cart] 
      @order = get_cart
      @order.update(user_id: current_user.id) if current_user.present?    
      item = Item.find(params[:id])
      if @order.items.present? && @order.items.map(&:id).include?(item.id)
        ordered_item = ItemOrder.where(item_id: item.id, order_id: @order.id).first
        # raise ordered_item.inspect
        ordered_item.update(units: ordered_item.units + 1) 
      else
        itemOrder = ItemOrder.create(order_id: @order.id , item_id: item.id , price: item.price, units: 1 )
      end
      redirect_to root_path     
    end

end
