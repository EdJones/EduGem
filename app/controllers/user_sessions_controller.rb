class UserSessionsController < ApplicationController
  def new
  end

  def create
    account = Account.authenticate(params[:login], params[:password])
    if account
      session[:account_id] = account.id
      redirect_to_target_or_default root_url, :notice => "Logged in successfully."
    else
      flash.now[:alert] = "Invalid login or password."
      render :action => 'new'
    end
  end

  def destroy
    session[:account_id] = nil
    redirect_to root_url, :notice => "You have been logged out."
  end
end
