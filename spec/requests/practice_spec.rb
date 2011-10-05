require 'spec_helper'
require 'pp'

describe "practice" do

context "when not logged in" do

    it "Shows you a list of didjis to practice on" do
	  visit practice_index_path do
      page.should have_content('Theme')
	  page.should have_content('Big Ones From Europe')
    end
  end
  
    it "Gives you a chance to log in or sign up" do
      visit practice_index_path 
	  page.should have_link('Login')
	  page.should have_link('Signup')
    end
  end
  
context "when logged in" do 
	#let(:current_game) {Factory(:game_stat)}

  before :each do
	@account = Account.where(:username => 'ej1c').first
	#@account = Factory.create(:account)
	@current_game = Factory(:game_stat)
	pp @account.email
	visit login_path
      fill_in 'Username or Email Address', :with => @account.email
      fill_in 'Password', :with => @account.password
	  click_button('Log in')
  end
   
    it "Shows username and high_score" do
	  pp @current_game
	  visit practice_index_path
	  pending("Add account data to view")
	  page.should have_content(@account.username )
	  page.should have_content(@current_game.high_score)
    end
	
	it "Shows a list of practice levels" do
	  visit practice_index_path
	  page.should have_content("US Battles" )
	  page.should have_content("Big Ones From Europe")
    end
	
	it "lets you pik a level to practice" do
	  visit practice_index_path
	  click_button('Play')
	  page.should have_content("How many can you get?")
	  page.should have_content("Julius Caesar takes a knife in the back")
    end	
	
	it "Asks you to build your own didji" do
	  visit practice_index_path
	  pending('Add Build Your Own to view')
	  click_button('Build Your Own')
	  page.should have_content("(Make your own Whendidji.)")
    end
	end

end
