require 'spec_helper'
require 'pp'

describe "play" do

context "when not logged in" do

    it "Lets you play the first level" do
	  visit play_path do
      page.should have_content('Drag Events from Here')
    end
  end
  
    it "Gives you a chance to log in" do
      visit play_path
	  page.should have_link('Login')
	  page.should have_link('Signup')
    end
  end
  
context "when logged in" do 
	#let(:current_game) {Factory(:game_stat)}

  before :each do
	@account = Factory.create(:account)
	@current_game = Factory(:game_stat)
	visit login_path
      fill_in 'Username or Email Address', :with => @account.email
      fill_in 'Password', :with => @account.password
	  click_button('Log in')
  end
   
    it "Shows username and high_score" do
	  pp @current_game
	  visit play_path
	  page.should have_content(@account.username )
	  page.should have_content(@current_game.high_score)
    end
	
	it "Shows a list of practice levels" do
	  visit play_path
	  page.should have_button("US Battles" )
	  page.should have_button("Big Ones From Europe")
    end
	
	it "Asks you to build your own didji" do
	  visit play_path
	  click_button('Build Your Own')
	  page.should have_content("(Make your own Whendidji.)")
    end
	
	it "Lets you submit your own suggested event" do
	  visit play_path
      fill_in 'Title', :with => "Title"
      fill_in 'Comment', :with => "You rock Ed"
	  click_button('Create')
	  pending('fix route or code to subscribe. Or just skip that')
	  page.should have_content("Your Suggested Events")
	  page.should have_content("You rock Ed")
    end
end

end
