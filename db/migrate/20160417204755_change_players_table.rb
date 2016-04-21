class ChangePlayersTable < ActiveRecord::Migration
  def change
    add_column :players, :activated, :string
  end
end
