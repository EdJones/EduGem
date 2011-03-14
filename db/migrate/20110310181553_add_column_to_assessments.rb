class AddColumnToAssessments < ActiveRecord::Migration
  def self.up
    add_column :assessments, :assessment_type, :string
  end

  def self.down
    remove_column :assessments, :assessment_type
  end
end
