class BonusRoundsController < ApplicationController
  # GET /bonus_rounds
  # GET /bonus_rounds.xml
  def index
    @bonus_rounds = BonusRound.all

    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @bonus_rounds }
    end
  end

  # GET /bonus_rounds/1
  # GET /bonus_rounds/1.xml
  def show
    @bonus_round = BonusRound.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @bonus_round }
    end
  end

  # GET /bonus_rounds/new
  # GET /bonus_rounds/new.xml
  def new
    @bonus_round = BonusRound.new

    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @bonus_round }
    end
  end

  # GET /bonus_rounds/1/edit
  def edit
    @bonus_round = BonusRound.find(params[:id])
  end

  # POST /bonus_rounds
  # POST /bonus_rounds.xml
  def create
    @bonus_round = BonusRound.new(params[:bonus_round])

    respond_to do |format|
      if @bonus_round.save
        format.html { redirect_to(@bonus_round, :notice => 'Bonus round was successfully created.') }
        format.xml  { render :xml => @bonus_round, :status => :created, :location => @bonus_round }
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @bonus_round.errors, :status => :unprocessable_entity }
      end
    end
  end

  # PUT /bonus_rounds/1
  # PUT /bonus_rounds/1.xml
  def update
    @bonus_round = BonusRound.find(params[:id])

    respond_to do |format|
      if @bonus_round.update_attributes(params[:bonus_round])
        format.html { redirect_to(@bonus_round, :notice => 'Bonus round was successfully updated.') }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @bonus_round.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /bonus_rounds/1
  # DELETE /bonus_rounds/1.xml
  def destroy
    @bonus_round = BonusRound.find(params[:id])
    @bonus_round.destroy

    respond_to do |format|
      format.html { redirect_to(bonus_rounds_url) }
      format.xml  { head :ok }
    end
  end
end
