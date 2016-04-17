class AddPlayerSecureToken < ActiveRecord::Migration
  def change
    add_column :players, :auth_token, :string
  end
end
