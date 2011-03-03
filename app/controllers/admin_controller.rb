class AdminController < ApplicationController
   # :before_filter :admin
   before_filter :login_required, :except => [:login]
   before_filter :authorized?, :except => [:login]
   


def my_games
      @my_games = MyGame.all

    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @my_games }
    end
  
end








private
    #  only allow Ed to access
   def authorized?
    logged_in? &&  current_user.login == "ej0c"
 end
end
