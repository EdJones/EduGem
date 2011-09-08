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
	#@account = Account.where(:username => 'ej0c').first
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
end

end
