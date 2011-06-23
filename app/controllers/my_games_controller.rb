class MyGamesController < ApplicationController
  before_filter :login_required, :except => [:login]
  

  # GET /my_games
  def select_digis
    logger.info "Processing select_didjis..." 
    @my_game = MyGame.find(params[:id])
    @my_digis = @my_game.my_digis
    render :update do |page|
      page.replace_html "adddidjis", :partial => "select_digis",  :locals => { :my_game => @my_game }
    end
    logger.info "QQQQQQQQQQQQQQQQQQQQQQQQQQQQQQQ...done with select_digis...QQQQQQQQQQQQQQQQQQQQQQQQQQQQQQQQQQQ" 
  end
  


  def my_digi_add
  #Convert ids from routing to objects
    logger.info "XXXXXXXXXXXXXXXXXXXXXXXXXXXX...my_digi_add...XXXXXXXXXXXXXXXXXXX"
  @my_game = MyGame.find(params[:id])
  @my_digi = MyDigi.find(params[:my_digis])
  logger.debug "@custom_event #{@cutom_event.inspect}"
  unless @my_game.uses_digi?(@my_digi)
 
    #add cusstom_event to list
    @my_game.my_digis << @my_digi
    flash[:notice] = 'Digdi was successfully added'
  else
    flash[:error] = 'Didgi already included'
  end
    logger.info "XXXXXXXXXXXXXXXXXXXXXXXXXXXX...my_digi_add...redirect...XXXXXXXXXXXXXXXXXXX"
  redirect_to :action => :my_digis,  :id => @my_game
end
  
  
  # POST /my_games/1/my_digi_remove?my_digis[]=
  def my_digi_remove
  #Convert ids from routing to objects
  @my_game = MyGame.find(params[:id])
  #Get list of custom events to remove from query string
  my_digi_ids = params[:my_digis]
  
   
  unless my_digi_ids.blank?
   logger.info "inside the unless" 
    my_digi_ids.each do |my_digi_id|
       logger.info "inside the loop" 
      my_digi = MyDigi.find(my_digi_id)
      if @my_game.uses_digi?(my_digi)
        logger.info "Removing digi from my_game #{my_digi.id}"
        @my_game.my_digis.delete(my_digi)
        flash[:notice] = 'Didgi was successfully deleted'
      end
    end
  end
  redirect_to :action => :my_digis,  :id => @my_game
end
  
  
  # Get /my_game/1/my_digis
  def my_digis
    @my_game = MyGame.find(params[:id])
    @my_digis = @my_game.my_digis
    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @my_games }
    end
    end
  
  
  
  
  # GET /my_games.xml
  def index
    @my_games =  MyGame.find(:all, :conditions => { :author => current_account.username })
    
    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @my_games }
    end
  end

  # GET /my_games/1
  # GET /my_games/1.xml
  def show
    @my_game = MyGame.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @my_game }
    end
  end

  # GET /my_games/new
  # GET /my_games/new.xml
  def new
    
    @my_game = MyGame.new
    @my_game.game_id = MyGame.last.id + 1
    @my_game.author = current_user.login

    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @my_game }
    end
  end

  # GET /my_games/1/edit
  def edit
    @my_game = MyGame.find(params[:id])
  end

  # POST /my_games
  # POST /my_games.xml
  def create
    @my_game = MyGame.new(params[:my_game])

    respond_to do |format|
      if @my_game.save
        flash[:notice] = 'MyGame was successfully created.'
        format.html { 
        #redirect_to(@my_game) }
        redirect_to :action => :my_digis,  :id => @my_game }
        format.xml  { render :xml => @my_game, :status => :created, :location => @my_game }
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @my_game.errors, :status => :unprocessable_entity }
      end
    end
  end

  # PUT /my_games/1
  # PUT /my_games/1.xml
  def update
    @my_game = MyGame.find(params[:id])

    respond_to do |format|
      if @my_game.update_attributes(params[:my_game])
        flash[:notice] = 'MyGame was successfully updated.'
        format.html { 
        # redirect_to(@my_game) }
        redirect_to :action => :my_digis,  :id => @my_game }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @my_game.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /my_games/1
  # DELETE /my_games/1.xml
  def destroy
    @my_game = MyGame.find(params[:id])
    @my_game.destroy

    respond_to do |format|
      unless current_account.username.admin
       format.html { redirect_to(my_games_url) }
      else 
       format.html  { redirect_to(admin_my_games_path) }
      end
      format.xml  { head :ok }
    end
  end
  
    def admin
      if current_account.username.admin == true
    @my_games =  MyGame.find(:all)
    
    respond_to do |format|
      format.html # admin.html.erb
      format.xml  { render :xml => @my_games }
    end
    else
      redirect_to :controller => :play, :action => :start
      end
  end
  
  def auth
    if ( current_user.login || current_user.admin == true)
    end
    end
    
end
