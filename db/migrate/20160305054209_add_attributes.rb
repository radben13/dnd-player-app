class AddAttributes < ActiveRecord::Migration
  def change
    create_table :special_attributes do |t|
      t.string :slug, index: true, unique: true
      t.string :name
      t.string :group
      t.text   :description
      t.text   :config_data, default: "{}"
    end
    
    create_join_table :items, :special_attributes do |t|
      t.integer :item_id
      t.integer :special_attribute_id
    end
    create_join_table :characters, :special_attributes do |t|
      t.integer :character_id
      t.integer :special_attribute_id
    end
  end
end
