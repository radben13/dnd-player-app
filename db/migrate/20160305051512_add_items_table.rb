class AddItemsTable < ActiveRecord::Migration
  def change
    
    create_table :items do |t|
      t.integer :weight
      t.string  :name
      t.string  :group, index: true
      t.string  :slug, unique: true, index: true
    end
    
    create_join_table :characters, :items do |t|
      t.integer :character_id
      t.integer :item_id
    end
  end
end
