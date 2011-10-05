require 'spec_helper'
require 'pp'

describe "Accounts" do
  describe "GET /accounts" do
    it "Blocks unauthorized access" do
      visit accounts_path
	  page.should have_content('You must first answer me these riddles three')
    end
  end
  
  
context "when logged in as regular user" do 
	#let(:current_game) {Factory(:game_stat)}

  before :each do
	@account = Factory.create(:account, :admin => false ) 
	@current_game = Factory(:game_stat)
	pp @account
	visit login_path
      fill_in 'Username or Email Address', :with => @account.email
      fill_in 'Password', :with => @account.password
	  click_button('Log in')
  end

    it "redirects attempts to view accounts to unauthorized page" do
      visit accounts_path
	  page.should_not have_content('Users for ')
	  page.should have_content('Unauthorized')
    end  
	
  
   it "doesn't let you edit other people's account" do
	  visit edit_account_path( 1 )
   	  page.should_not have_content('Users for ')
	  page.should have_content('Unauthorized')
   end
 end  
  
  context "when logged in as admin" do 
	#let(:current_game) {Factory(:game_stat)}

  before :each do
	@account = Factory.create(:account, :admin => true ) 
	@current_game = Factory(:game_stat)
	pp @account
	visit login_path
      fill_in 'Username or Email Address', :with => @account.email
      fill_in 'Password', :with => @account.password
	  click_button('Log in')
  end

    it "Shows a List of Users" do
      visit accounts_path
	  page.should have_content('Username')
	  page.should have_content('Email')
	  page.should have_content('testdude')
    end  
  end	
end
