class AddAnswerKeyToAnswers < ActiveRecord::Migration
  def self.up
    add_column :answers, :answer_key, :string
  end

  def self.down
    remove_column :answers, :answer_key
  end
end
