class UsersController < ApplicationController
  

  def new
    @user = User.new
  end

  def register
    #raise params.inspect
    @user = User.new(user_params)
    if @user.save
       #flash[:notice] = "Sucessfully Registered!"
    else
      @errors = @user.errors.full_messages     
    end
    respond_to do |format|
      format.js
    end
  end

  
  def validation
   # raise params.inspect
    if params[:lastname].present?
      if params[:lastname].length < 6
        render json: {:msg => false}
      else
        render json: {:msg => true}
      end
    end
    
    if params[:email].present?
      @user = User.find_by_email(params[:email])
      if @user.present?
          render json: {:avalable => true}
      else
          render json: {:avalable => false}      
      end
   end 

  end


  def login
    #raise params.inspect

    user = User.find_by_email(params[:email])   
    if user && user.authenticate(params[:password])
       session[:user_id] = user.id
      order= get_cart.update(user_id: user.id) if session[:cart].present?
      
      # order.item_orders.create()
      


      # flash[:notice] = "Your Signed In!"
     #  redirect_to root_path
    else
      @loginerr = "Invalid email/password"
      
      end
      respond_to do|format|
        format.js       
    end
  end


  def logout
    session[:user_id] = nil
    flash[:notice] = "signed out Sucessfully!"
    session[:cart]= nil
    redirect_to root_path
  end

  def edit_profile
  end

  def getlogin
  end
  
private
  def user_params
     params.require(:user).permit(:firstname, :lastname, :email, :ph, :password, :password_confirmation)    	
  end

end



#User.first.orders.all.map(&:items)