class AddModifierToGameLevel < ActiveRecord::Migration
  def self.up
    add_column :game_levels, :modifier, :string
  end

  def self.down
    remove_column :game_levels, :modifier
  end
end
