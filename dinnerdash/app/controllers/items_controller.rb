class ItemsController < ApplicationController
  def index
  end

  def create
  end

  def itemdescription
    
  	@item = Item.find(params[:item_id])
  end


  def item_cart

  end

  def delete
  end
end
