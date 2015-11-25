class CartController < ApplicationController
require 'paypal_adaptive'

  def display_cart
    @total_amount=0
    @order=Order.find(params[:order_id])
    @order.item_orders.each { |item| @total_amount = @total_amount + (item.price ) }   
    @order.item_orders.where(:status => "In-Progress")
  end


  def paypal_response
    @a = Order.find(params[:order_id])
    @a.update(status: "order completed sucessfully!");
    session[:cart]={}
    session[:cart]= Order.create.id
    #render :text=>"transaction failed"
    #redirect_to root_path
  end
  
  def add
    session[:cart]=Order.create.id unless session[:cart] 
    @order = get_cart
    @order.update(user_id: current_user.id) if current_user.present?    
    item = Item.find(params[:id])
    if @order.items.present? && @order.items.map(&:id).include?(item.id)
      ordered_item = ItemOrder.where(item_id: item.id, order_id: @order.id).first
      units = ordered_item.units + 1
      price = units * item.price
      puts "Units: "+ units.to_s
      puts "Price: " + price.to_s
      puts "Order Price: "+ ordered_item.price.to_s

      ordered_item.update(units: units, price: price) 
    else
      itemOrder = ItemOrder.create(order_id: @order.id , item_id: item.id , price: item.price, units: 1 )
    end
    redirect_to root_path     
  end


  def remove_cart
    i=ItemOrder.find(params["item_order_id"])
    i.destroy
    redirect_to root_path
  end

  def cart_update
    @cart_access=ItemOrder.find(params["item_order"].to_i)
    @cart_access.update(units: params["unit"].to_i, price: params["unit"].to_i* @cart_access.item.price)
    @order = @cart_access.order
    @total_amount=0
    @order.item_orders.each { |item| @total_amount = @total_amount + (item.price) }
    render json: {:msg => (@cart_access.price), :item_id => params["item_order"], :total_amount => @total_amount}
     # raise a.inspect
      #redirect_to root_path
  end

  def save_cart
    #raise params.inspect
    if current_user.present?
      pay_request = PaypalAdaptive::Request.new   
      data = {
        "returnUrl" => "http://localhost:3000/paypal_response?order_id=#{params[:order_id]}",
        "requestEnvelope" => {"errorLanguage" => "en_US"},
        "currencyCode"=>"USD",
        "receiverList"=>{"receiver"=>
         [{"email"=>"marojusaieswar-facilitator@gmail.com", "amount"=>"#{params[:total_amount]}"}]},
        "cancelUrl"=>"http://localhost/remove_cart",
        "actionType"=>"PAY",
        "ipnNotificationUrl"=>"http://localhost:3000/display_cart"             
      }
      pay_response = pay_request.pay(data)
    
      if pay_response.success?
        redirect_to pay_response.approve_paypal_payment_url
      else
        puts pay_response.errors.first['message']
        render :text=>"transaction failed!"
      end
    else
    redirect_to users_getlogin_path
  end
end
end
