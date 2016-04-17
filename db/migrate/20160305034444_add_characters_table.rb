class AddCharactersTable < ActiveRecord::Migration
  def change
    create_table :characters do |t|
      t.string :name
      t.string :race
      t.text   :background
      # JSON Object to track use of some dynamic data
      t.text   :config_data
      t.belongs_to :player, index: true
    end
    
    create_table :character_levels do |t|
      t.string :level_class
      t.belongs_to :character, index: true
    end
  end
end
