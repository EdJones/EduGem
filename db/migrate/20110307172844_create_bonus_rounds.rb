class CreateBonusRounds < ActiveRecord::Migration
  def self.up
    create_table :bonus_rounds do |t|
      t.integer :level
      t.string :message1
      t.string :message2
      t.integer :points
      t.string :points_message
      t.string :level_up_message
      t.string :modifier

      t.timestamps
    end
  end

  def self.down
    drop_table :bonus_rounds
  end
end
