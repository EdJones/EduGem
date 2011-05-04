class TrafficsController < ApplicationController
  
  before_filter :login_required, :except => [:login]
  before_filter :authorized?, :except => [:login]
  # GET /traffics
  # GET /traffics.xml
  def index
    @traffics = Traffic.find(:all, :order => "created_at")

    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @traffics }
    end
  end

  # GET /traffics/1
  # GET /traffics/1.xml
  def show
    @traffic = Traffic.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @traffic }
    end
  end

  # GET /traffics/new
  # GET /traffics/new.xml
  def new
    @traffic = Traffic.new

    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @traffic }
    end
  end

  # GET /traffics/1/edit
  def edit
    @traffic = Traffic.find(params[:id])
  end

  # POST /traffics
  # POST /traffics.xml
  def create
    @traffic = Traffic.new(params[:traffic])
    @previous = Traffics.find(:last, :conditions => {:ip => @traffic.ip}) 
    logger.debug "***********************@previous #{@previous.inspect}"
    unless previous.nil?
    logger.debug "***********************@previous.domain #{@previous.domain}"
      @traffic.update_attribute(:domain => @previous.domain, :city => @previous.city)
      @traffic.domain = @previous.domain
      @traffic.city = @previous.city
    end
    
    respond_to do |format|
      if @traffic.save
        flash[:notice] = 'Traffic was successfully created.'
        format.html { redirect_to(@traffic) }
        format.xml  { render :xml => @traffic, :status => :created, :location => @traffic }
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @traffic.errors, :status => :unprocessable_entity }
      end
    end
  end

  # PUT /traffics/1
  # PUT /traffics/1.xml
  def update
    @traffic = Traffic.find(params[:id])
    @traffics = Traffic.find(:all, :conditions => {:ip => @traffic.ip})
    respond_to do |format|
      if @traffic.update_attributes(params[:traffic])
        flash[:notice] = 'Traffic was successfully updated.'
        @traffics.each do |t|
          t.update_attribute(:city, @traffic.city)
          t.update_attribute(:domain, @traffic.domain)
        end
        format.html { redirect_to(traffics_path) }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @traffic.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /traffics/1
  # DELETE /traffics/1.xml
  def destroy
    @traffic = Traffic.find(params[:id])
    @traffic.destroy

    respond_to do |format|
      format.html { redirect_to(traffics_url) }
      format.xml  { head :ok }
    end
  end
  
  private
     def authorized?
    logged_in? &&  current_user.login == "ej0c"
 end
end
