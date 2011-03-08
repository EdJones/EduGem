class AddChoiceToBonusRound < ActiveRecord::Migration
  def self.up
    add_column :bonus_rounds, :choice, :string
  end

  def self.down
    remove_column :bonus_rounds, :choice
  end
end
