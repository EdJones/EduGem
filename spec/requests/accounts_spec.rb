require 'spec_helper'

describe "Accounts" do
  describe "GET /accounts" do
    it "Blocks unauthorized access" do
      visit accounts_path
	  page.should have_content('You must first answer me these riddles three')
    end
  end
end
