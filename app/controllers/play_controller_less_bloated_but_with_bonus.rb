class PlayController < ApplicationController
  

def index
  redirect_to :controller => 'play', :action => 'start'
end

  def start
   #who is coming to visit?
   #logger.debug "request.remote_ip: #{request.remote_ip}"
   #@location = locateIp()
   #logger.debug "*****@location: #{@location}"
   #visitor = Traffic.create(:ip => request.remote_ip)
    @game_id = 0
    @time = Time.now
    @high_scores = GameStat.find(:all, :order => "high_score DESC", :limit => "5") - GameStat.find(:all, :conditions => {:login => 'ej0c'})
   #get_events(6, 19)
    @events = Event.find(:all, :order => "idee") 
    @didjis = MyDigi.find(:all, :conditions => { :public_play => true }) - MyDigi.find(:all, :conditions => {:id => '13'})
          
    if logged_in?     
      @current_game = GameStat.find_or_create_by_login(:login =>current_account.username, :game_id => @game_id, :last_level => 0, :game_duration => 0, :high_score => 0)
   
     # For when we have multiple versions:
     session[:current_game] = @current_game
  
     #A hack bridging the original static page structure to dynamic game creation. These are the levels of play
     session[:game_structure] = [[2, "a"], [2, "b"],[3, "p"], [3, "b"], [3, "v"], [4, "a"], [4, "b"], [4, "w"], [5, "h"], [5, "i"], [6, "a"]]

     @current_game.update_start_time() 

 # need to separate current game stats from current player's cum stats  OR Current_player line needs to be eeked out of views
  @current_player = GameStat.find_by_login(current_account.username)
  else
    #@traffic = Traffic.create

 end
 # to process event suggestions
 @event_suggestion = EventSuggestion.new
 end
 
 
 
 def gameUpdate2
     
   if logged_in?
           logger.debug "session[:current_score] #{session[:current_score] }"
    session[:current_score] = params[:score].to_i
    #logger.debug "params[:score].to_i #{params[:score].to_i }"
    session[:current_score] = params[:score].to_i       
    session[:current_game].update_high_score(params[:score].to_i)
    session[:current_game].update_last_level(1)
    session[:current_game].update_game_duration
    @level = 2
    respond_to do |format|
      format.js  {
        render :update do |page|
            page.replace_html 'highScore', :text => session[:current_game].high_score
            page.replace_html "message", :text => ""
            page.replace_html "displayGameTime", :inline => "<%= 'Time: ' + session[:current_game].time_since_start.to_i.to_s  + ' sec'  %>"
            page.replace_html 'game', :partial => "level"+ @level.to_s
        end 
        }
     end
    
    else 
      render :update do |page|
        page.replace_html "game", :partial => "signup"
      end
    end
  end
        
    
  def gameUpdate2a    
    @gameLevel = GameLevel.find_by_level_and_modifier(2, 'a')
    @next_level = GameLevel.find_by_level_and_modifier(2, 'b')
    @link_message = "Continue with Level" + @next_level.level.to_s + ": " + @next_level.tagline
    refresh_game()
  end

  def gameUpdate2b 
    @gameLevel = GameLevel.find_by_level_and_modifier(2, 'b')
    @next_level = GameLevel.find_by_level_and_modifier(3, 'p')    
    refresh_game()
  end  
  
 

  
   
    def level_up
        gameLevel =   session[:game_structure].shift
        next_level =   session[:game_structure].first
        @gameLevel = GameLevel.find_by_level_and_modifier(gameLevel[0], gameLevel[1])              
        @next_level = GameLevel.find_by_level_and_modifier(next_level[0], next_level[1]) 
       refresh_game()
    end      
          

           
    def gameUpdateDone   
      session[:current_score] = params[:score].to_i
      session[:current_game].update_high_score(params[:score].to_i)
      session[:current_game].update_game_duration
       # to process event suggestions
        @event_suggestion = EventSuggestion.new
      end    
      

  

#----------------------------------------------------------------------------------
  private
  
  # Update game view for normal levels
 def refresh_game()   
    @level = @gameLevel.level.to_s + @gameLevel.modifier
    @nextlevel = @next_level.level.to_s + @next_level.modifier
   if logged_in?
    session[:current_score] = params[:score].to_i
    session[:current_game].update_high_score(params[:score].to_i)
    session[:current_game].update_last_level(@level.chop.to_i)
    session[:current_game].update_game_duration
    @highScore = session[:current_game].high_score
    @displayGameTime = "<%= raw 'Time: ' + session[:current_game].time_since_start.to_i.to_s  + ' sec'  %>"
   else
     @highScore = " "
     @displayGameTime = " "
   end


    @level_tagline = @gameLevel.tagline
    @eventsStartIdee = @gameLevel.start_idee
    @eventsEndIdee = @gameLevel.end_idee
    @eventsSourceList = get_events(@eventsStartIdee, @eventsEndIdee)
    
    @link_message = "Continue with Level" + @next_level.level.to_s + ": " + @next_level.tagline
    @event_suggestion = EventSuggestion.new
   render :update do |page|
        if logged_in?
       page.replace_html "highScore", :text => @highScore.to_s
       page.replace_html "displayGameTime", :inline => @displayGameTime
     end
     logger.info("reached the render")
       page.replace_html "displayCorrect", :text => "0/0";
       logger.info("reached the displayCorrect")
       page.replace_html "message", :text => ""
       if @gameLevel.level == 6
           page.replace_html "game", :partial => "gameUpdateDone"
       #elsif @next_level.level >= 3

       else    
            page.replace_html "game", :partial => "level"
           #page.replace_html "game", :partial => "level"+ @level.to_s
       end
     end

end
  
  
  # Update scoring for bonus results
  def refresh_scoring(new_points, correct, partial)
    session[:current_score] =  session[:current_score] + new_points
    render :update do |page|
       page.replace_html "displayPoints", :text => session[:current_score]
       page.replace_html "highScore", :text => session[:current_game].high_score
       page.replace_html "message", :text => ""
       page.replace_html "displayCorrect", :text => correct
       page.replace_html "displayGameTime", :inline => "<%= 'Time: ' + session[:current_game].time_since_start.to_i.to_s  + ' sec'  %>"
       page.replace_html "bonus_content", :partial => bonus_result
  end   
end


  def refresh_scoring_a()
    session[:current_score] =  session[:current_score] + @bonus_round.points
    render :update do |page|
       page.replace_html "displayPoints", :text => session[:current_score]
       page.replace_html "highScore", :text => session[:current_game].high_score
       page.replace_html "message", :text => ""
       page.replace_html "displayCorrect", :text => @bonus_round.message2
       page.replace_html "displayGameTime", :inline => "<%= 'Time: ' + session[:current_game].time_since_start.to_i.to_s  + ' sec'  %>"
       page.replace_html "bonus_content", :partial => "bonus_result"
  end   
end

# For now, just pull them out of master list, 14 in a row. Later it will accept custom games.
def get_events(first, last)
  @game_id = 0
     if @game_id == 0 
      @events = Event.find(:all, 
          :order => "idee") 
          @eventsTimeBase = @events[0..5]
        @events =   (@events[@eventsStartIdee..@eventsEndIdee] ) 

   else 
     # @events = Custom_event.find(:all, 
       #     :conditions => "game_id = @game_id",
         #   :order => "idee")
          end 
        end
        
 # a new version to accept custom games.
def get__custom_events(game, didji)
  @game_id = 0
     if @game_id == 0 
      @events = Event.find(:all, 
          :order => "idee") 
          @eventsTimeBase = @events[0..5]
        @events =   (@events[@eventsStartIdee..@eventsEndIdee] ) 

   else 
     # @events = Custom_event.find(:all, 
       #     :conditions => "game_id = @game_id",
         #   :order => "idee")
          end 
      end



end
