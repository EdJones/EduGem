require 'spec_helper'

describe "game_levels" do
    it "Should try to list the game levels" do
      visit '/game_levels'
      #response.status.should be(200)
      page.should have_content('Listing game_levels')
   #   page.should have_content('Show')
  end
  
      it "Should let user start new level" do
          visit '/game_levels'
    click_on("New Game level")
      #response.status.should be(200)
      page.should have_content('Sublevel')
  end
end

describe "new game_level" do
    it "Should display form for a new game level" do
      visit '/game_levels/new'
      #response.status.should be(200)
      page.should have_content('New game_level')
   #   page.should have_content('Show')
  end
  

end
