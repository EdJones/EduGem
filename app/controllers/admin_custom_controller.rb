class AdminCustomController < ApplicationController
   # :before_filter :admin
   before_filter :login_required, :except => [:login]
   before_filter :authorized?, :except => [:login]
   
   active_scaffold :custom_event do |config|
#    config.ignore_columns.add [:description, :image_url] 
#    config.create.columns = [:id, :title, :year]
  config.label = "Custom Events"
  config.columns = [:idee, :title, :year, :pointValue, :author, :public, :scale]
  config.list.per_page = 300
#config.actions << :sortable
config.list.sorting = { :idee => :asc }
end








private
    #  only allow Ed to access
   def authorized?
    logged_in? &&  current_user.login == "ej0c"
 end
end
