class AddDescriptionToItems < ActiveRecord::Migration[5.2]
  def change
    add_column :items, :description, :text, null: false
  end
end
