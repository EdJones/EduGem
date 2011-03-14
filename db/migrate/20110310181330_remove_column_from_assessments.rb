class RemoveColumnFromAssessments < ActiveRecord::Migration
  def self.up
    remove_column :assessments, :type
  end

  def self.down
    add_column :assessments, :type, :string
  end
end
