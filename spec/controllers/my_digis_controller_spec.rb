require 'spec_helper'

describe MyDigisController do
render_views


 before( :each ) do
	 @account = Account.where(:username => 'ej0c').first
	 puts @account.inspect
	 controller.stub!(:current_account).and_return(@account)
	 controller.stub!(:logged_in?).and_return(:current_account)
	 session[:account_id] = @account.id	 
	 controller.stub!(:login_required)
 end

  describe "GET index" do
    it "says 'Your Custom Event groups'" do
      get :index
      response.body.should =~ /(didjis)/m
    end
  end

  describe "GET my_digis/66/" do
    it "Previews the MyDigi'" do
      get :show, :id=> '66'
      response.body.should =~ /How many can you get?/m
    end
  end
  
    describe "GET my_digis/66/custom_events" do
    it "Lets you edit the MyDigi" do
      get "custom_events", :id=> '66'
      response.body.should =~ /Events for my_digi #66/m
    end
  end
  
#describe "View event details" do
describe "GET my_digis/66/custom_events" do
  it "Should show a table of events" do
     #visit '/my_digis/66/custom_events'
	 visit custom_events_my_digi_path('66')
     page.should have_content('Events')
	 #response.body.should =~ /Now put them in the order you wish game players to see them/m

  end
end

end