class CreateItemsCategories < ActiveRecord::Migration[5.2]
  def change
    create_table :items_categories, id: :integer do |t|
      t.integer :item_id, foreign_key: true
      t.integer :category_id, foreign_key: true
      t.timestamps
    end
  end
end
