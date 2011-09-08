require 'spec_helper'
require "selenium-webdriver"

describe "MyGames" do
  before :each do
    #User.make(:email => 'user@example.com', :password => 'caplin')
	@account = Account.where(:username => 'ej0c').first
	visit login_path
      fill_in 'Username or Email Address', :with => @account.email
      fill_in 'Password', :with => 'emmitt'
	  click_button('Log in')
  end
  
    it "Shows list of games" do
      visit my_games_path
	  page.should have_content('My Custom Games')
    end

    it "Lets you modify a game" do
      visit my_games_path
	  click_button('Add/Edit Didjis')
	  page.should have_content('My Custom Game')
    end
	
    it "Lets you preview the game" do
      visit my_games_path
	  pending("add a preview action")
	  #click_button('Preview')
	  #page.should have_content('How many can you get?')
    end
	
	 it "Lets you create a new game" do
      visit my_games_path
	  click_button('Create a New Game')
	  page.should have_content('Start Creating Your Own Game')
    end	
	
	 it "Lets you delete a game", :js => true do
      visit my_games_path
	  click_link('Destroy')
	  #On confirmation, click ('no') cause we're using devel database
	  page.driver.browser.switch_to.alert.dismiss
    end
end
