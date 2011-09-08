describe "the signup process" do
   
   it "signs me up" do
     lambda do 
	  visit signup_path
      fill_in 'Username', :with => 'ej'+rand(1000).to_s + 'c'
	  fill_in 'Email Address', :with => "ej" + rand(1000).to_s + "c@edwincjones.com"
      fill_in 'Password', :with => 'diddle'
	  fill_in 'Confirm Password', :with => 'diddle'
	  click_button('Sign up')
	  page.should have_content('ej1c')
	 end.should change(Account, :count).by(1)
  end
  
end

describe "the sign in process", :type => :request do
  before :each do
    #User.make(:email => 'user@example.com', :password => 'caplin')
	@account = Account.where(:username => 'ej0c').first
	visit login_path
  end

  it "signs me in" do
      fill_in 'Username or Email Address', :with => @account.email
      fill_in 'Password', :with => 'emmitt'
	  click_button('Log in')
	  page.should have_content('Welcome back!')
  end
  
    it "logs me out" do
      fill_in 'Username or Email Address', :with => @account.email
      fill_in 'Password', :with => 'emmitt'
	  click_button('Log in')
	  click_link('Logout')
	  page.should have_content('Login')
  end
  

end