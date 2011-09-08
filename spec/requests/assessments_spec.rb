require 'spec_helper'
require "selenium-webdriver"

describe "Assessments" do

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
  
    it "Shows list of assessments" do
      visit assessments_path
	  page.should have_content('Level')
	  page.should have_content('Assessment Type')
    end

    it "Lets you edit an assessments" do
      visit assessments_path
	  click_link('Edit')
	  page.should have_content('Edit Assessment')
    end
	
    it "Lets you preview the Assessment" do
      visit assessments_path
	  click_link('Show')
	  page.should have_content('Assessment')
    end
	
	 it "Lets you create a new Assessment" do
      visit assessments_path
	  click_button('New Assessment')
	  page.should have_content('Name')
	  page.should have_content('Assessment type')
    end	
	
	 it "Lets you delete an Assessment", :js => true do
      visit assessments_path
	  click_link('Destroy')
	  #On confirmation, click ('no') cause we're using devel database
	  page.driver.browser.switch_to.alert.dismiss
    end
end

end