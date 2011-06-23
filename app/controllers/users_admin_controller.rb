class UsersAdminController < ApplicationController

  before_filter :login_required, :except => [:login]
  before_filter :authorized?, :except => [:login]
   
  active_scaffold :account do |config|
  config.label = "Users for WhenDidIt?"
  config.columns = [:login, :name, :email, :subscribed, :invitation_limit, :state, :admin, :password, :password_confirmation]
  config.list.per_page = 30
#  config.actions << :sortable
#  config.sortable.column = :idee
end

private
    #  only allow Ed to access
   def authorized?
    logged_in? &&  current_user.login == "ej0c"
 end
end
