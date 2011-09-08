require 'spec_helper'
#require "selenium-webdriver"

describe "Admin" do
describe "when not logged in" do  
    it "Blocks unauthorized access" do
      visit assessments_path
	  page.should have_content('You must first answer me these riddles three')
    end
  end
  
describe "when logged in" do 
  before :each do
    #User.make(:email => 'user@example.com', :password => 'caplin')
	@account = Account.where(:username => 'ej0c').first
	visit login_path
      fill_in 'Username or Email Address', :with => @account.email
      fill_in 'Password', :with => 'emmitt'
	  click_button('Log in')
  end
  
    it "Shows admin home page" do
      visit admin_index_path
	  page.should have_content('Admin this Thing')
	  #page.should have_link('Accounts')
    end
end
end