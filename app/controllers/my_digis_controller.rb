class MyDigisController < ApplicationController
 before_filter :login_required, :except => [:login]

 
  # GET /my_digis
  # GET /my_digis.xml
  def index
    @my_digis = MyDigi.where(:author => current_account.username )

    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @my_digis }
    end
  end
  

  def show
    #@my_digi.custom-events may not be sorted by idee. Should this be changed in model or here?
    @events = CustomEvent.find(:all, 
          :order => "idee")
    @my_digi = MyDigi.find(params[:id])
    @eventsSourceList = @my_digi.custom_events
    logger.debug "@my_digi: #{@my_digi.inspect}"
    logger.debug "@my_digi.sequences.last: #{@my_digi.sequences.inspect}"
    logger.debug "@my_digi.custom_events: #{@my_digi.custom_events.inspect}"
    
    @eventsStartIdee = @my_digi.custom_events.first.idee
        @eventsEndIdee = @my_digi.custom_events.last.idee
        @eventsTimeBase = @events[0..5]
    #logger.debug "@eventsSourceList #{@eventsSourceList.inspect}"
   #redirect_to :action => :custom_events,  :id => @my_digi
  end


  def custom_events
    @my_digi = MyDigi.find(params[:id])
    @custom_events = @my_digi.custom_events
    @my_games = MyGame.find(:all, :conditions => { :author => current_account.username })
    #Hack until I put game in session store
    #@my_game = MyGame.find(4)
    #------
    @used_by_games = @my_digi.my_games
  end
    
 # POST /my_digis/1/custom_event_add?custom_event_id=2
#note: no real query string


# in model?
#  def didji_position
#    my_digi_id = MyDigi.find(params[:id])
#     sequence = Sequence.find(:all, :conditions => {:my_digi_id =>  my_digi_id, :custom_event_id =>  id } )
#    logger.debug "sequence[0].position #{sequence[0].position}"
#    sequence[0].position
#    end


def custom_event_add
  #Convert ids from routing to objects
  @my_digi = MyDigi.find(params[:id])
  @custom_event = CustomEvent.find(params[:custom_events])
  #logger.debug "@custom_event: #{@custom_event.first.inspect}"
  unless @my_digi.uses_event?(@custom_event)
    logger.debug "@my_digi.sequences.last: #{@my_digi.sequences.last.inspect} and go on"
    logger.debug "@custom_event: #{@custom_event.inspect} and go on"
      @my_digi.custom_events << @custom_event 
      logger.debug "@my_digi.sequences.last: #{@my_digi.sequences.last.inspect}"
  #b = @my_digi.sequences.last
  #c = b.update({:position => 12})
    flash[:notice] = 'Event was successfully added'
  else
    flash[:error] = 'Event already included'
  end
  redirect_to :action => :custom_events,  :id => @my_digi
end

def custom_events_edit
end

# POST /my_digis/1/custom_event_remove?custom_events[]=

def custom_event_remove
  #Convert ids from routing to objects
  @my_digi = MyDigi.find(params[:id])
  #Get list of custom events to remove from query string
  custom_event_ids = params[:custom_events]
   
  unless custom_event_ids.blank?
   logger.info "inside the unless" 
    custom_event_ids.each do |custom_event_id|
       logger.info "inside the loop" 
      custom_event = CustomEvent.find(custom_event_id)
      if @my_digi.uses_event?(custom_event)
        logger.info "Removing event from my_digi #{custom_event.id}"
####Check this next line. may be inconsistent with new positioning.
 custom_event.sequences.first.remove_from_list
        @my_digi.custom_events.delete(custom_event)
        flash[:notice] = 'Event was successfully deleted'
      end
    end
  end
  redirect_to :action => :custom_events,  :id => @my_digi
end

    def select_games
    logger.info "Processing select_games..." 
    @my_games = MyGame.find(:all, :conditions => { :author => current_account.username })
    #@my_game = MyGame.find(params[:id])
    #@my_digis = @my_game.my_digis
    @my_digi = MyDigi.find(params[:id])
    render :update do |page|
      page.replace_html "select_games", :partial => "select_games", :locals => { :games => @my_digi.non_attached_games }, :method => :get 
    end
        
  end
    
  def order
      logger.info "*************************Processing sort..."
      @my_digi = MyDigi.where(params[:id]).first
	  logger.debug "@my_digi:  #{@my_digi}"
	  logger.debug "params[:custom_events]:  #{params[:custom_events]}"
      params[:custom_events].each_with_index do |id, index|
        @sequence = Sequence.where(:my_digi_id =>  @my_digi.id, :custom_event_id =>  id  )
		logger.debug "@sequence  #{@my_digi}"
        sequence[0].position = index + 1 
        logger.debug "sequence:  #{sequence.inspect}"
        #sequence.each do |s|
         # s.position = 
          #update_all(['position=?', index+1], ['id=?', id])
        #end
        sequence[0].save
    end
  render :nothing => true
end

    
    def make_public
      @my_digi = MyDigi.find(params[:id])
	  @my_digi.update_attribute('public', true)
      @my_digi.update_attribute('public_play', true)
      respond_to do |format|
      format.html { redirect_to(my_digis_url) }
      format.xml  { render :xml => @my_digis }
		end
    end
    
     def make_private
      @my_digi = MyDigi.find(params[:id])
      @my_digi.update_attribute('public', false)

          respond_to do |format|
      format.html { redirect_to(my_digis_url) }
      format.xml  { render :xml => @my_digis }
    end
  end
  
          def make_playable
      @my_digi = MyDigi.find(params[:id])
      @my_digi.update_attribute('public_play', true)
          respond_to do |format|
      format.html { redirect_to(admin_my_digis_url) }
      format.xml  { render :xml => @my_digis }
    end
  end
  
  def pickem
    @my_digi = MyDigi.find(:all)

    respond_to do |format|
      format.html # pickem.html.erb
      format.xml  { render :xml => @my_digi }
    end
  end
  
  
  def new
    @my_digi = MyDigi.new
    @my_digi.author = current_account.username
    @my_digi.group = MyDigi.find(:all, :conditions => { :author => current_account.username }).length + 1
     logger.debug "@my_digi: #{@my_digi.inspect}"
    #@my_events = CustomEvent.find(:all, :offset => 200, :limit => 14 )
   #@my_digi.custom_events<<@my_events

    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @my_digi }
    end
  end

  # GET /my_digis/1/edit
  def edit
    @my_digi = MyDigi.find(params[:id])
  end

  # POST /my_digis
  def create
    @my_digi = MyDigi.new(params[:my_digi])
    
    #@my_events = CustomEvent.find_by_id(7)
    #@my_events = CustomEvent.find(:all, :offset => 6, :limit => 14 )
   #@my_digi.custom_events<<@my_events

    respond_to do |format|
      if @my_digi.save
        flash[:notice] = 'MyDigi was successfully created.'
        #format.html { redirect_to(@my_digi) }
        format.html{ redirect_to( :action => 'custom_events', :id => @my_digi.id ) }
        format.xml  { render :xml => @my_digi, :status => :created, :location => @my_digi }
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @my_digi.errors, :status => :unprocessable_entity }
      end
    end
  end

  # PUT /my_digis/1
  def update
    @my_digi = MyDigi.find(params[:id])

    respond_to do |format|
      if @my_digi.update_attributes(params[:my_digi])
        flash[:notice] = 'MyDigi was successfully updated.'
        format.html { redirect_to(my_digis_path) }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @my_digi.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /my_digis/1
  def destroy
    @my_digi = MyDigi.find(params[:id])
        if @my_digi.destroy
        flash[:notice] = 'MyDigi was successfully created.'
		#	    respond_to do |format|
        #format.js
      #format.html { redirect_to(users_url) }
      #format.xml  { head :ok }
    #end
            @my_digis = MyDigi.find(:all, :conditions => { :author => current_account.username })
            render :update do |page|
				page.replace_html "didji_list", :partial => "list_my_didgis" 
			end
       end
  end

    def admin
      if current_user.admin == true
    @my_digis =  MyDigi.find(:all)
    
    respond_to do |format|
      format.html # admin.html.erb
      format.xml  { render :xml => @my_digis}
    end
    else
      redirect_to :controller => :play, :action => :start
      end
  end
  
  def auth
    if ( current_user.login || current_user.admin == true)
    end
    end

private
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
        end
        
  def list_position
    return custom_event.didji_position(@my_digi) + 5      
    end
