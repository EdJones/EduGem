class AddFieldsToAccounts < ActiveRecord::Migration
  def self.up
    add_column :accounts, :invitation_limit, :integer
    add_column :accounts, :invitation_id, :integer
    add_column :accounts, :subscribed, :boolean
    add_column :accounts, :teacher, :boolean
    add_column :accounts, :author, :boolean
    add_column :accounts, :admin, :boolean
  end

  def self.down
    remove_column :accounts, :admin
    remove_column :accounts, :author
    remove_column :accounts, :teacher
    remove_column :accounts, :subscribed
    remove_column :accounts, :invitation_id
    remove_column :accounts, :invitation_limit
  end
end
