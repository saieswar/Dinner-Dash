class Item < ActiveRecord::Base
	belongs_to :category
    has_many :item_orders
    has_many :orders, :through => :item_orders
    has_many :images

end
