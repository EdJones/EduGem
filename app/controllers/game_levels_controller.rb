class GameLevelsController < ApplicationController
  # GET /game_levels
  # GET /game_levels.xml
  def index
    @game_levels = GameLevel.all

    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @game_levels }
    end
  end

  # GET /game_levels/1
  # GET /game_levels/1.xml
  def show
    @game_level = GameLevel.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @game_level }
    end
  end

  # GET /game_levels/new
  # GET /game_levels/new.xml
  def new
    @game_level = GameLevel.new

    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @game_level }
    end
  end

  # GET /game_levels/1/edit
  def edit
    @game_level = GameLevel.find(params[:id])
  end

  # POST /game_levels
  # POST /game_levels.xml
  def create
    @game_level = GameLevel.new(params[:game_level])

    respond_to do |format|
      if @game_level.save
        format.html { redirect_to(@game_level, :notice => 'Game level was successfully created.') }
        format.xml  { render :xml => @game_level, :status => :created, :location => @game_level }
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @game_level.errors, :status => :unprocessable_entity }
      end
    end
  end

  # PUT /game_levels/1
  # PUT /game_levels/1.xml
  def update
    @game_level = GameLevel.find(params[:id])

    respond_to do |format|
      if @game_level.update_attributes(params[:game_level])
        format.html { redirect_to(@game_level, :notice => 'Game level was successfully updated.') }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @game_level.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /game_levels/1
  # DELETE /game_levels/1.xml
  def destroy
    @game_level = GameLevel.find(params[:id])
    @game_level.destroy

    respond_to do |format|
      format.html { redirect_to(game_levels_url) }
      format.xml  { head :ok }
    end
  end
end
