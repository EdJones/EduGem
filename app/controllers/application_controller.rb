class ApplicationController < ActionController::Base
  include ControllerAuthentication
  protect_from_forgery
 
  rescue_from CanCan::AccessDenied do |exception|
	flash[:error] = "Access denied!"
	redirect_to root_url
  end  
  
  def current_ability
  @current_ability ||= Ability.new(current_account)
end
  
  private  
    
  def current_user  
 #logger.debug "called current user  in AppController "    
 #@current_user ||= Account.find(session[:username]) if session[:username] 
 end  
  
    
  #helper_method :current_user 
helper_method :current_account 
end
