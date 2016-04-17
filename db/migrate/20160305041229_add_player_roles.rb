class AddPlayerRoles < ActiveRecord::Migration
  def change
    create_table :roles do |t|
      t.string :name
      t.belongs_to :player, index: true
    end
  end
end
