class PlayController < ApplicationController
  

def index
  redirect_to :controller => 'play', :action => 'start'
end

def start
    @game_id = 0
    @time = Time.now
    @high_scores = GameStat.find(:all, :order => "high_score DESC", :limit => "5") - GameStat.find(:all, :conditions => {:login => 'ej0c'})
       @events = CustomEvent.find(:all, 
          :order => "idee")
   #get_events(6, 19)
   @my_digi = MyDigi.find("64")
       @eventsSourceList = @my_digi.custom_events
    @eventsStartIdee = @my_digi.custom_events.first.idee
        @eventsEndIdee = @my_digi.custom_events.last.idee
        logger.debug "@my_digi.custom_events.length #{@my_digi.custom_events.length}"
        logger.debug "@eventsSourceList.length #{@eventsSourceList.length}"
        @eventsTimeBase = @events[0..5]

    @didjis = MyDigi.find(:all, :conditions => { :public_play => true }) - MyDigi.find(:all, :conditions => {:id => '13'})
          
    if logged_in?     
      @current_game = GameStat.find_or_create_by_login(:login =>current_account.username, :game_id => @game_id, :last_level => 0, :game_duration => 0, :high_score => 0)
   
     # For when we have multiple versions:
     session[:current_game] = @current_game
  
     #A hack bridging the original static page structure to dynamic game creation. These are the levels of play
     session[:game_structure] = [[2, "a"], [2, "b"],[3, "p"], [3, "b"], [3, "v"], [4, "a"], [4, "b"], [4, "w"], [5, "h"], [5, "i"], [6, "a"]]
      logger.debug "session[:game_structure] #{session[:game_structure]}" 
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
            page.replace_html 'game', :partial => "choose"
        end 
        }
     end
    
    else 
      render :update do |page|
        page.replace_html "game", :partial => "signup"
      end
    end
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
      

def level
                if logged_in?   
  @current_user = current_account.username
  end
    #@my_digi.custom-events may not be sorted by idee. Should this be changed in model or here?
    @events = CustomEvent.find(:all, 
          :order => "idee")
    @my_digi = MyDigi.find(params[:id])
    @eventsSourceList = @my_digi.custom_events
    @eventsStartIdee = @my_digi.custom_events.first.idee
        @eventsEndIdee = @my_digi.custom_events.last.idee
        #logger.debug "@my_digi.custom_events.length #{@my_digi.custom_events.length}"
        @eventsTimeBase = @events[0..5]
      logger.debug "session[:game_structure] #{session[:game_structure]}"     
        gameLevel =   session[:game_structure].shift
        next_level =   session[:game_structure].first
        @gameLevel = GameLevel.find_by_level_and_modifier(gameLevel[0], gameLevel[1])              
        @next_level = GameLevel.find_by_level_and_modifier(next_level[0], next_level[1]) 
        
   @possible_score = 0
   @eventsSourceList.each do |e| @possible_score = @possible_score + e.pointValue end 
     logger.debug "@possible_score #{@possible_score}"
         @highScore = session[:current_game].high_score
    @displayGameTime = "<%= raw 'Time: ' + session[:current_game].time_since_start.to_i.to_s  + ' sec'  %>"

     render :update do |page|
        if logged_in?
       page.replace_html "highScore", :text => @highScore.to_s
       page.replace_html "displayGameTime", :inline => @displayGameTime
   end

       page.replace_html "displayCorrect", :text => "0/0";
       page.replace_html "message", :text => ""
       if @gameLevel.level == 6
           page.replace_html "game", :partial => "gameUpdateDone"
       else    
           page.replace_html "game", :partial => "level"
       end
     end   
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
       page.replace_html "displayCorrect", :text => "0/0";
       page.replace_html "message", :text => ""
       if @gameLevel.level == 6
           page.replace_html "game", :partial => "gameUpdateDone"
       else    
           page.replace_html "game", :partial => "level"
       end
     end

end
  
  
  # Update scoring for bonus results

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

def content
    
end


end
