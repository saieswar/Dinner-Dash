class CreateItems < ActiveRecord::Migration
  def change
    create_table :items do |t|
      t.string :title
      t.string :description
      t.integer :category_id
      
      t.timestamps null: false
    end
  end
end
