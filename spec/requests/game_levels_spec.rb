require 'spec_helper'
require "selenium-webdriver"

describe "GameLevels" do
  
#GameLevels is a transition controller from the original version of Whendidji. 
# To create a level, it fetched events froms fromthe events table in groups of fourteen.

context "when not logged in" do  
    it "Blocks unauthorized access" do
      visit my_digis_path
	  page.should have_content('You must first answer me these riddles three')
    end
  end
  
context "when logged in" do 
  before :each do
	  #@account = Factory.create(:account)
	  @account = Account.where(:username => 'testdude').first
	  visit login_path
      fill_in 'Username or Email Address', :with => @account.email
      fill_in 'Password', :with => 'secret'
	  click_button('Log in')
  end
  
    it "Shows list of game_levels" do
      visit game_levels_path
	  page.should have_content('Listing game_levels')
	  page.should have_content('US Battles')
    end

    it "Lets you modify a game_level" do
      visit game_levels_path
	  click_link('Edit')
	  page.should have_content('Editing game_level')
	  page.should have_content('Start idee')
    end
	
    it "Lets you view a game level's data" do
      visit game_levels_path
	  click_link('Show')
	  page.should have_content('Tagline:')
    end
	
	 it "Lets you delete a game_level" do
      visit game_levels_path
	  click_link('Destroy')
	  pending('Test for delete game level')
	  page.should have_content('New Didji')
    end	
	
	 it "lets you create a new game level" do
      visit game_levels_path
	  click_link('New Game level')
	  page.should have_content('New game_level')
    end
  end
end