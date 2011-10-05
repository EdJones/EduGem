require 'spec_helper'
#require "selenium-webdriver"
require 'pp'

describe "Admin" do
context "when not logged in" do  
    it "Blocks unauthorized access" do
      visit assessments_path
	  page.should have_content('You must first answer me these riddles three')
    end
  end
  
context "when logged in, but not as admin" do  
    it "Blocks unauthorized access" do
      visit assessments_path
	  page.should have_content('You must first answer me these riddles three')
    end
  end
  
context "when logged in as admin" do 
  before :each do
	admin_account = Account.where(:id => 46).first
	pp admin_account
	visit login_path
      fill_in 'Username or Email Address', :with => admin_account.email
      fill_in 'Password', :with => 'secret'
	  click_button('Log in')
  end
  
    it "Shows admin home page" do
      visit admin_index_path
	  page.should have_content('Admin this Thing')
	  #page.should have_link('Accounts')
    end
end
end