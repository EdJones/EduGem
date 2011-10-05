class AddCorrectToQuestions < ActiveRecord::Migration
  def self.up
    add_column :questions, :correct, :integer
  end

  def self.down
    remove_column :questions, :correct
  end
end
