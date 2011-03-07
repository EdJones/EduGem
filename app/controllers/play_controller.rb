class PlayController < ApplicationController
  


def index
  redirect_to :controller => 'play', :action => 'start'
end

  def start
   #who is coming to visit?
   #logger.debug "request.remote_ip: #{request.remote_ip}"
   #@location = locateIp()
   logger.debug "*****@location: #{@location}"
   #visitor = Traffic.create(:ip => request.remote_ip)
   @game_id = 0
   @time = Time.now
   @high_scores = GameStat.find(:all, :order => "high_score DESC", :limit => "5") - GameStat.find(:all, :conditions => {:login => 'ej0c'})
   #get_events(6, 19)
      @events = Event.find(:all, 
          :order => "idee") 
    @didjis = MyDigi.find(:all, :conditions => { :public_play => true }) - MyDigi.find(:all, :conditions => {:id => '13'})
          
      if logged_in?     
    # Short for:
    #    unless GameStat.find_by_login(current_user.login)
    #  ... @current_game = GameStat.create({:login => current_user.login, :game_id => @game_id, :last_level => 0, :game_duration => 0, :high_score => 0})
  @current_game = GameStat.find_or_create_by_login(:login =>current_account.username, :game_id => @game_id, :last_level => 0, :game_duration => 0, :high_score => 0)
   
   # For when we have multiple versions:
  session[:current_game] = @current_game
  session[:game_structure] = [[3, "p"], [3, "b"], [3, "v"], [4, "a"], [4, "b"], [4, "w"], [5, "h"], [5, "i"], [6, "a"]]

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
    session[:current_game].update_high_score(params[:score].to_i)
    session[:current_game].update_last_level(1)
    session[:current_game].update_game_duration
    @level = 2
    respond_to do |format|
      #format.html # index.html.erb
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

    #     @events = Event.find(:all, 
     #     :order => "idee")
  end
        
    
  def gameUpdate2a    
    @gameLevel = GameLevel.find_by_level_and_modifier(2, 'a')
@next_level = GameLevel.find_by_level_and_modifier(2, 'b')
@link_message = "Continue with Level" + @next_level.level.to_s + ": " + @next_level.tagline
    refresh_game()
  end

  def gameUpdate2b 
    @gameLevel = GameLevel.find_by_level_and_modifier(2, 'b')
@next_Level = GameLevel.find_by_level_and_modifier(3, 'p')    
    refresh_game()
  end  
  
  # Render the Bonus attempt view
    def gameUpdate2bonus    
      @level = "2bonus"
         if logged_in?
    session[:current_score] = params[:score].to_i
    session[:current_game].update_high_score(params[:score].to_i)
    session[:current_game].update_last_level(@level.chop.to_i)
    session[:current_game].update_game_duration
    @highScore = session[:current_game].high_score
    @displayGameTime = "<%= 'Time: ' + session[:current_game].time_since_start.to_i.to_s  + ' sec'  %>"
    render :update do |page|
       page.replace_html "displayGameTime", :text => @displayGameTime
       page.replace_html "game", :partial => "level2_bonus"
       page.replace_html "highScore", :text => @highScore
       page.replace_html "message", :text => ""
       page.replace_html "displayCorrect", :text => "0/0";
    end
   else
     @highScore = " "
     @displayGameTime = " "
      render :update do |page|
        page.replace_html "game", :partial => "signup2"
      end
   end
  end
  
  # Process bonus attempts
     def bonus2_result
     @current_game = GameStat.find_by_login(current_account.username)
     #session[:current_score] = params[:score].to_i
   if params[:date_choice] == "yep" && params[:date2_choice] == "yep" 
     @current_game.update_high_score(10000)
      partial= "result2_4" 
      temp = refresh_scoring(10000, "2/2", partial)
    elsif params[:date_choice] == "yep"
      @current_game.update_high_score(3000)
      partial= "result2_3"
      temp = refresh_scoring(3000, "1/2", partial)
    elsif params[:date2_choice] == "yep"
      @current_game.update_high_score(7000)
      partial= "result2_2"
      temp = refresh_scoring(7000, "1/2", partial)
    else 
      partial= "result2_1"
      temp = refresh_scoring(0, "0/2", partial)
    end
  end
  
  # experimental: trying to not send entire list to browser
  def gameUpdate3p
    gameLevel =   session[:game_structure].pop
    @gameLevel = GameLevel.find_by_level_and_modifier(gameLevel[0], gameLevel[1])      
    #@level = "3p"
    logger.debug(@gameLevel)
    @next_level = GameLevel.find_by_level_and_modifier(3, 'b')
    @level = @gameLevel.level.to_s + @gameLevel.modifier
    refresh_game()    

  end    
  
  #For this one, try with the GameLevels model determining vars
  def gameUpdate3b 
    @gameLevel = GameLevel.find_by_modifier('b')
    @next_level = GameLevel.find_by_level_and_modifier(3, 'v') 
    refresh_game()
  end
  
    def gameUpdate3z 
        @gameLevel = GameLevel.find_by_level_and_modifier(3, 'z')      
        @next_level = GameLevel.find_by_level_and_modifier(4, 'a')        
    refresh_game()
  end


    def gameUpdate3v
        @gameLevel = GameLevel.find_by_level_and_modifier(3, 'v')      
        @next_level = GameLevel.find_by_level_and_modifier(3, 'z')     
        refresh_game()
  end

# Render the Bonus attempt view
    def gameUpdate3bonus    
    session[:current_score] = params[:score].to_i
    render :update do |page|
       page.replace_html "displayGameTime", :inline => "<%= 'Time: ' + session[:current_game].time_since_start.to_i.to_s  + ' sec'  %>"
       page.replace_html "game", :partial => "level3_bonus"
       page.replace_html "highScore", :text => session[:current_game].high_score
       page.replace_html "message", :text => ""
       page.replace_html "displayCorrect", :text => "0/0";
   end
  end
  
  # Process bonus attempts
     def bonus3_result
     @current_game = GameStat.find_by_login(current_user.login)
     #session[:current_score] = params[:score].to_i
   if params[:date_choice] == "yep" && params[:date2_choice] == "yep" && params[:date3_choice] == "yep"
     @current_game.update_high_score(20000)
      partial= "result3_4" 
      temp = refresh_scoring(10000, "2/2", partial)
    elsif params[:date_choice] == "yep"
      @current_game.update_high_score(3000)
      partial= "result3_3"
      temp = refresh_scoring(3000, "1/2", partial)
    elsif params[:date2_choice] == "yep"
      @current_game.update_high_score(7000)
      partial= "result3_2"
      temp = refresh_scoring(7000, "1/2", partial)
    else 
      partial= "result3_1"
      temp = refresh_scoring(0, "0/2", partial)
    end
  end

    def gameUpdate4a    
       @gameLevel = GameLevel.find_by_level_and_modifier(4, 'a')
       @next_level = GameLevel.find_by_level_and_modifier(4, 'b') 
       refresh_game()
   end    
   
    def level_up
        gameLevel =   session[:game_structure].shift
        next_level =   session[:game_structure].first
        @gameLevel = GameLevel.find_by_level_and_modifier(gameLevel[0], gameLevel[1])              
        @next_level = GameLevel.find_by_level_and_modifier(next_level[0], next_level[1]) 
       refresh_game()
    end      
          
    def gameUpdate4b    
        @gameLevel = GameLevel.find_by_level_and_modifier(4, 'b')
        @next_level = GameLevel.find_by_level_and_modifier(4, 'w') 
        refresh_game()
     end   
      
    def gameUpdate4w
        @gameLevel = GameLevel.find_by_level_and_modifier(4, 'w')    
        @next_level = GameLevel.find_by_level_and_modifier(5, 'h')         
        refresh_game()
    end    
                
    def gameUpdate5h    
        @gameLevel = GameLevel.find_by_level_and_modifier(5, 'h')
        @next_level = GameLevel.find_by_level_and_modifier(5, 'i')
        refresh_game()
      end 
                      
    def gameUpdate5i    
        @gameLevel = GameLevel.find_by_level_and_modifier(5, 'i')
        @next_level =  "gameUpdateDone"      
        refresh_game()
      end 
           
    def gameUpdateDone   
      session[:current_score] = params[:score].to_i
      session[:current_game].update_high_score(params[:score].to_i)
      
      session[:current_game].update_game_duration
       # to process event suggestions
        @event_suggestion = EventSuggestion.new
      end    
      
  def agreement
    
  end
  
# ---------------------------------------------------------------------------------------------
# May not be using any of this.
# May use for refactoring
def preview
    @my_digis = MyDigi.find(:all, :conditions => { :public_play => true })

    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @my_digis }
    end
end

def show
    @my_digis = MyDigi.find(:all, :conditions => { :public_play => true })
    @events = CustomEvent.find(:all, 
          :order => "idee")
    @my_digi = MyDigi.find(params[:id])
    @eventsSourceList = @my_digi.custom_events
    @eventsStartIdee = @my_digi.custom_events.first.idee
        @eventsEndIdee = @my_digi.custom_events.last.idee
        @eventsTimeBase = @events[0..5]
    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @my_digis }
    end
end


# try this with custom games and digis
  def start2
   @game_id = 0
   @time = Time.now
   #get_events(6, 19)
      @events = Event.find(:all, 
          :order => "idee") 
          
          
      if logged_in?     
    # Short for:
    #    unless GameStat.find_by_login(current_user.login)
    #  ... @current_game = GameStat.create({:login => current_user.login, :game_id => @game_id, :last_level => 0, :game_duration => 0, :high_score => 0})
  @current_game = GameStat.find_or_create_by_login(:login =>current_user.login, :game_id => @game_id, :last_level => 0, :game_duration => 0, :high_score => 0)
   
   # For when we have multiple versions:
  session[:current_game] = @current_game

  @current_game.update_start_time() 

 # need to separate current game stats from current player's cum stats  OR Current_player line needs to be eeked out of views
  @current_player = GameStat.find_by_login(current_user.login)
 end
 # to process event suggestions
 @event_suggestion = EventSuggestion.new
 end
#----------------------------------------------------------------------------------
# private metods
#----------------------------------------------------------------------------------
  private
  
  # Update game view for normal levels
 def refresh_game()
    # @events = Event.find(:all, 
      #    :order => "idee")
      
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
    
   render :update do |page|
        if logged_in?
       page.replace_html "highScore", :text => @highScore.to_s
       page.replace_html "displayGameTime", :inline => @displayGameTime
     end
     logger.info("reached the render")
       page.replace_html "displayCorrect", :text => "0/0";
       logger.info("reached the displayCorrect")
       page.replace_html "message", :text => ""
       if @next_level.level == 6
           page.replace_html "game", :partial => "gameUpdateDone"
       elsif @next_level.level >= 3
           page.replace_html "game", :partial => "level"
       else    
           page.replace_html "game", :partial => "level"+ @level.to_s
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
       page.replace_html "bonus_content", :partial => partial
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


# ------ Site traffic
  	def locateIp
		#ip = "123.123.123.123";
       #logger.debug "***** locateIp: request.remote_ip: #{request.remote_ip}"
		ip =  	request.remote_ip
		ips = ip.to_s
		url = "http://iplocationtools.com/ip_query.php?ip="+ips
logger.debug "***** ips:: #{ips}"
		xml_data = Net::HTTP.get_response(URI.parse(url)).body
logger.debug "***** xml_data: #{xml_data}"
                xmldoc = REXML::Document.new(xml_data)

		# Now get the root element
		root = xmldoc.root
		city = ""
		regionName = ""
		countryName = ""

		# This will take country name...
		xmldoc.elements.each("Response/CountryName") {
		|e| countryName << e.text
	    }

		# Now get city name...
		xmldoc.elements.each("Response/City") {
   		|e| city << e.text
	    }

		# This will take regionName...
		xmldoc.elements.each("Response/RegionName") {
   		|e| regionName << e.text
	    }

     	ipLocation = city +", "+regionName+", "+countryName

	 return ipLocation
   end #end of method locateIp
end
