require 'spec_helper'

describe "Users" do
context "When not logged in" do
    it "blocks access" do
      visit users_path
      page.should have_content('How many can you get?') 
    end
  end
end