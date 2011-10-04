class ApplicationController < ActionController::Base
  include ControllerAuthentication
  protect_from_forgery
 
    
  private  
    
  def current_user  
 #logger.debug "called current user  in AppController "    
 #@current_user ||= Account.find(session[:username]) if session[:username] 
 end  
  
    
  #helper_method :current_user 
helper_method :current_account 
end
