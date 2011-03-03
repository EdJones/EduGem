class CreateGameLevels < ActiveRecord::Migration
  def self.up
    create_table :game_levels do |t|
      t.integer :game_id
      t.integer :level
      t.integer :sublevel
      t.integer :start_idee
      t.integer :end_idee
      t.string :tagline
      t.binary :custom_digi
      t.integer :my_digi_id

      t.timestamps
    end
  end

  def self.down
    drop_table :game_levels
  end
end
