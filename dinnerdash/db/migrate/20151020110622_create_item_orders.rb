class CreateItemOrders < ActiveRecord::Migration
  def change
    create_table :item_orders do |t|
      t.integer :order_id
      t.integer :item_id
      t.integer :units
      t.integer :price

      t.timestamps null: false
    end
  end
end
