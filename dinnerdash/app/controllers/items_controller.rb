class ItemsController < ApplicationController
  def index
  end

  def create
  end

  def itemdescription
    
  	@item = Item.find(params[:item_id])
  end

  def items_category
    @category = Category.find(params["id"].to_i)
    @items = @category.items
    @categories = Category.all
    render 'home/index'

  end
  def item_cart

  end

  def delete
  end
end
