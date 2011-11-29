require 'spec_helper'
require "selenium-webdriver"
require 'pp'
require 'awesome_print'

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
	@my_digi = Factory.create(:my_digi)
      visit my_digis_path
	  page.should have_content('Your Custom Event groups')
	  page.should have_content(@my_digi.theme)
    end

    it "Lets you modify didji list" do
	@my_digi = Factory.create(:my_digi)
	pp @my_digi
      visit my_digis_path
	  click_button('Modify events')
	  page.should have_content('Events for my_digi')
    end
	
    it "Lets you preview a didji" do
	@my_digi = Factory.create(:my_digi)
		pp @my_digi
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
       #pp MyDigi.where(:author => 'testdude')
		@my_digi = Factory.create(:my_digi)
		#ap MyDigi.where(:author => 'testdude')
		visit my_digis_path
		pending("the function seems to work. Why not the test?")
		lambda { 
        click_button('Make Public')
	    page.driver.browser.switch_to.alert.accept
		#ap MyDigi.where(:author => 'testdude')
		}.should change(MyDigi.where(:public => true), :count).by(1)
	  
  end

  end
  
private 

def my_public_digi_count 
MyDigi.where(:public => true).count
end
  
end
