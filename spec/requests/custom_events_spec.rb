require 'spec_helper'
require "selenium-webdriver"

describe "Custom Events" do

describe "when not logged in" do  
    it "Blocks unauthorized access" do
      visit assessments_path
	  page.should have_content('You must first answer me these riddles three')
    end
  end
  
describe "when properly logged in for tests " do  
pending("fix the factories, and get ed's username out")
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
  
    it "Shows list of custom events" do
      visit custom_events_path
	  page.should have_content('Your Very Own custom_events')
    end

    it "Lets you modify a custom event" do
      visit custom_events_path
	  click_button('Modify Event')
	  page.should have_content('Editing custom_event')
    end
	
	 it "Lets you create a new event" do
      visit custom_events_path
	  click_button('New custom_event')
	  page.should have_content('New custom_event')
    end	
	
	it "Lets you see your updated event in the list" do 
		visit edit_custom_event_path(191)
		click_button('Update')
		page.should have_content('Your Very Own custom_events')
    end	
end

end