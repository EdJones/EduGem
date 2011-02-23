class AccountsController < ApplicationController
  before_filter :login_required, :except => [:new, :create]

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
end
