class AddPlayersTable < ActiveRecord::Migration
  def change
    create_table :players do |t|
      t.string :email, unique: true, index: true
      t.string :password_digest
      t.string :player_tag, unique: true, index: true
      t.text   :bio
      t.string :profile_image
    end
  end
end
