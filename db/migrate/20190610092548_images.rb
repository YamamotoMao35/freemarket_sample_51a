class Images < ActiveRecord::Migration[5.2]
  def change
    drop_table :images
  end
end
