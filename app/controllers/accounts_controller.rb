class AccountsController < ApplicationController
  before_filter :login_required, :except => [:new, :create]
  before_filter :authorized?, :except => [:new, :create, :edit, :update]
  
active_scaffold :account do |conf|
    conf.label = "Users for WhenDidIt?"
	conf.columns = [:username, :email, :created_at, :admin, :teacher, :author]
	conf.list.per_page = 30
  end
  

  
  def new
    @account = Account.new
  end

  def create
    @account = Account.new(params[:account])
    if @account.save
      session[:account_id] = @account.id
      redirect_to root_url, :notice => "Thank you for signing up! You are now logged in."
    else
      render :action => 'new'
    end
  end

  def edit
    @account = current_account
  end

  def update
    @account = current_account
    if @account.update_attributes(params[:account])
      redirect_to root_url, :notice => "Your profile has been updated."
    else
      render :action => 'edit'
    end
  end
  
  def unauthorized
  redirect_to root_url, :notice => "You must be an admin to access this page."
  
  end
  private
    #  only allow admin to access
   
  def authorized?
   unless logged_in? &&  current_account.admin == true
   render :action => 'unauthorized'
   end
 end
end
