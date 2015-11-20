class CreateItemCategories < ActiveRecord::Migration
  def change
    create_table :item_categories do |t|
      t.integer :category_id
      t.integer :item_id

      t.timestamps null: false
    end
  end
end
