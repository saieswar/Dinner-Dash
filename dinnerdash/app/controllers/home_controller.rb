class HomeController < ApplicationController
  def index
    @items =  Item.all
    @categories = Category.all
  end
  def items_category
    @category = Category.find(params["id"].to_i)
    @items = @category.items
    @categories = Category.all
    render 'index'

  end
end
