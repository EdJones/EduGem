require 'spec_helper'
require "selenium-webdriver"

describe "Assessments" do

describe "when not logged in" do  
    it "Blocks unauthorized access" do
      visit assessments_path
	  page.should have_content('You must first answer me these riddles three')
    end
  end
  
context "when logged in" do 

  before :each do
	@account = Account.where(:username => 'common_user').first
	visit login_path
      fill_in 'Username or Email Address', :with => @account.email
      fill_in 'Password', :with => 'secret'
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
	
	 it "Lets you create a new Assessment", :js => true do
      visit assessments_path
	  click_button('New Assessment')
	  pending("Add selenium queries?")
	  page.should have_content('Name')
	  page.should have_content('Assessment type')
    end	
	
	it "Lets you select from four new Assessment types", :js => true do 
      visit assessments_path
	  click_button('New Assessment')
	  fill_in 'Name', :with => 'TestAssessment'
	  select('Fill-in', :from => 'assessment[assessment_type]')
	  click_button('Create new assessment')
	  page.should have_link('Add a question')
	  page.should have_content('Fill-in')
	  #page.should have_content('TestAssessment')
    end	
	
	it "Lets you edit a multiple choice assessment" do
	
	pending("write test for multiple choice")
	end
	
	it "Lets you edit a true false assessment" do
	
	pending("write test for true false")
	end
	
	
	 it "Lets you delete an Assessment", :js => true do
      visit assessments_path
	  click_link('Destroy')
	  #On confirmation, click ('no') cause we're using devel database
	  page.driver.browser.switch_to.alert.dismiss
    end
end

end