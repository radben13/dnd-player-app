class AddPlayerSessions < ActiveRecord::Migration
  def change
    create_table :player_sessions do |t|
      t.string :session_id, index: true
      t.integer :player_id, index: true, foreign_key: true
      t.timestamps
    end
  end
end
