require 'spec_helper'
require "selenium-webdriver"
  
  
describe "BonusRounds" do

describe "when not logged in" do  
    it "Blocks unauthorized access" do
      visit bonus_rounds_path
	  page.should have_content('You must first answer me these riddles three')
    end
  end


describe "View and change my bonus rounds" do
  before :each do
    #User.make(:email => 'user@example.com', :password => 'caplin')
	@account = Account.where(:username => 'ej0c').first
	visit login_path
      fill_in 'Username or Email Address', :with => @account.email
      fill_in 'Password', :with => 'emmitt'
	  click_button('Log in')
  end
  
    it "Shows list of my bonus rounds" do
      visit bonus_rounds_path
	  page.should have_content('Level')
	  page.should have_content('Points message')
    end

    it "Lets you edit a bonus rounds" do
      visit bonus_rounds_path
	  click_link('Edit')
	  page.should have_content('Editing bonus_round')
    end
	
	 it "Lets you create a new bonus round" do
      visit bonus_rounds_path
	  click_link('New Bonus round')
	  page.should have_content('New bonus_round')
    end	
	
	 it "Lets you delete an bonus round", :js => true do
      visit bonus_rounds_path
	  click_link('Destroy')
	  #On confirmation, click ('no') cause we're using devel database
	  page.driver.browser.switch_to.alert.dismiss
    end
end

  
  
  
  
end
