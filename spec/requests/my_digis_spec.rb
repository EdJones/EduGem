require 'spec_helper'
require "selenium-webdriver"

describe "MyDigis" do
  
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
  
    it "Shows list of digis" do
      visit my_digis_path
	  page.should have_content('Your Custom Event groups')
	  page.should have_content('TestDidji')
    end

    it "Lets you modify didji list" do
      visit my_digis_path
	  click_button('Modify events')
	  page.should have_content('Events for my_digi')
	  page.should have_content('No Beer 4 U! The 18th Ammendment outlaws acohol.')
    end
	
    it "Lets you preview a didji" do
      visit my_digis_path
	  click_button('Preview')
	  page.should have_content('How many can you get?')
    end
	
	 it "Lets you create a new didji" do
      visit my_digis_path
	  click_button('Create a new Didji')
	  page.should have_content('New Didji')
    end	
	
	 it "Lets you make a didji public", :js => true do
        lambda do 
	    visit my_digis_path
        click_button('Make Public')
	    page.driver.browser.switch_to.alert.accept
	    #within '#didji_list' do
	    #  find('tr', :text => '111').should_not have_button('Make Public')
	  end.should change(MyDigi.public_play, :count).by(1)
  end

  end
end
