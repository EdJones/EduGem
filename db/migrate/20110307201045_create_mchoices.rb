class CreateMchoices < ActiveRecord::Migration
  def self.up
    create_table :mchoices do |t|
      t.string :prompt
      t.string :answer1
      t.string :answer2
      t.string :anser3
      t.string :answer4
      t.string :hint
      t.integer :correct
      t.string :errormsg1
      t.string :errormsg2
      t.string :errormsg3
      t.string :errormsg4
      t.string :modifier

      t.timestamps
    end
  end

  def self.down
    drop_table :mchoices
  end
end
