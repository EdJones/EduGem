class MyAccountController < ApplicationController
before_filter :login_required, :except => [:login]

def index

    @current_game = GameStat.find_or_create_by_login(:login =>current_account.username, :game_id => @game_id, :last_level => 0, :game_duration => 0, :high_score => 0)
     @invites = Invite.find(:all, :conditions => { :from => current_account.username })
# to process new user invitations
     @invite = Invite.new(params[:invite])
     @invite.from =current_account.username
     
      # to process event suggestions
 @event_suggestion = EventSuggestion.new
   @event_suggestion.user = current_account.username
     
     @event_suggestions = EventSuggestion.find(:all, :conditions => { :user => current_account.username })
   end
   
   def subscribe
         @current_game = GameStat.find_or_create_by_login(:login =>current_account.username, :game_id => @game_id, :last_level => 0, :game_duration => 0, :high_score => 0)
          @survey = Survey.new
          @survey.login = current_account.username
          @invites = Invite.find(:all, :conditions => { :from => current_account.username })

     end
     
        def enroll
         @current_game = GameStat.find_or_create_by_login(:login =>current_account.username, :game_id => @game_id, :last_level => 0, :game_duration => 0, :high_score => 0)
          # to process new user invitations
     @invite = Invite.new(params[:invite])
     @invite.from =current_account.username
     
     # to list previous user invitations
          @invites = Invite.find(:all, :conditions => { :from => current_account.username })

     end
  end
