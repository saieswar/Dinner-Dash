class Item < ActiveRecord::Base
	has_many :item_categories
	has_many :categories, :through => :item_categories
    has_many :item_orders
    has_many :orders, :through => :item_orders
    has_many :images

end
