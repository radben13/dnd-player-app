class AddItemConfigurationAndCharacterJournal < ActiveRecord::Migration
  def change
    add_column :items, :config_data, :text
    
    create_table :journal_entries do |t|
      t.string     :title
      t.text       :content
      t.belongs_to :character
    end
  end
end
