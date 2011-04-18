class CustomEventsController < ApplicationController
 
 before_filter :login_required, :except => [:login]
 
 # GET /custom_events
  # GET /custom_events.xml
  

#Get /my_digi/1/event_list
def event_list
  @custom_event = Custom_event.find(params[:id])
  end
  
      # @events.each { |i|   flash[:notice] = 'once' + i            }
  def index
    # permit 'admin'

    #      if CustomEvent.count == 0 
      #      @events = Event.find(:all, :order => 'idee')
    #@events.each do |e| CustomEvent.create( :title => e.title, :idee => e.idee, :year => e.year, :description => e.description, :pointValue => e.pointValue, :wikip_url => e.wikip_url, :public => false )   CustomEvent.save end
      #CustomEvent.save
      
         @custom_events = CustomEvent.find(:all, :conditions => {:author => current_user.login}, :order => 'idee')
         @public_events = CustomEvent.find(:all, :conditions => {:public => true}) - @custom_events
    #if @custom_events.length == 0 
      #@custom_events = Event.find(:all)
      #@custom_events.save
   # end
    
    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @custom_events }
    end
  end

  # GET /custom_events/1
  # GET /custom_events/1.xml
  def show
    @custom_event = CustomEvent.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @custom_event }
    end
  end

  # GET /custom_events/new
  # GET /custom_events/new.xml
  def new
    @custom_event = CustomEvent.new

    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @custom_event }
    end
  end

  # GET /custom_events/1/edit
  def edit
    @custom_event = CustomEvent.find(params[:id])
  end

  # POST /custom_events
  # POST /custom_events.xml
  def create
    @custom_event = CustomEvent.new(params[:custom_event])
  #@custom_event.idee = @custom_event.id + 1
  @custom_event.author = current_user.login
    respond_to do |format|
      if @custom_event.save
        flash[:notice] = 'CustomEvent was successfully created.'
        format.html { redirect_to( :action => 'index') }
        format.xml  { render :xml => @custom_event, :status => :created, :location => @custom_event }
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @custom_event.errors, :status => :unprocessable_entity }
      end
    end
  end

  # PUT /custom_events/1
  # PUT /custom_events/1.xml
  def update
    @custom_event = CustomEvent.find(params[:id])

    respond_to do |format|
      if @custom_event.update_attributes(params[:custom_event])
        flash[:notice] = 'CustomEvent was successfully updated.'
        @custom_events = CustomEvent.find(:all)
        @public_events = CustomEvent.find(:all, :conditions => {:public => true}) 
        format.html { render :action => "index" }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @custom_event.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /custom_events/1
  # DELETE /custom_events/1.xml
  def destroy
    @custom_event = CustomEvent.find(params[:id])
    @custom_event.destroy

    respond_to do |format|
      format.html { redirect_to(custom_events_url) }
      format.xml  { head :ok }
    end
  end
  
  def populate
    if CustomEvent.count == 0 
    Event.each do |e|
        CustomEvent.new( :title => e.title, :idee => e.idee, :year => e.year, :description => e.description, :pointValue => e.pointValue, :wikip_url => e.wikip_url, :public => false )
      end
      CustomEvent.save

    respond_to do |format|
      format.html { render :action => "index" }
      format.xml  { head :ok }
    end
  end
  end
  

    
  
  
    def admin
     #permit admin


  if current_user.admin?     
         @custom_events = CustomEvent.find(:all, :order => 'idee')
  #####Various db fixes#####################################
      #      if CustomEvent.count == 0 
      #      @events = Event.find(:all, :order => 'idee')
    #@events.each do |e| CustomEvent.create( :title => e.title, :idee => e.idee, :year => e.year, :description => e.description, :pointValue => e.pointValue, :wikip_url => e.wikip_url, :public => false )   CustomEvent.save end
      #CustomEvent.save
      
         #fix the nil 'public' attributes
         #@custom_events = CustomEvent.find(:all, :order => 'idee', :conditions => {:author => 'ej0c' })
         #@custom_events.each do |c|
          #c.update_attribute('public', true)
          # end
          
        #fix the nil 'idee' attributes
         #@nil_idee_custom_events = CustomEvent.find(:all, :order => 'idee', :conditions => {:idee => 'nil' })
         #@nil_idee_custom_events.each do |c|
          #c.update_attribute('idee', true)
          # end

    #if @custom_events.length == 0 
      #@custom_events = Event.find(:all)
      #@custom_events.save
   # end
    ################################################
             @public_events = CustomEvent.find(:all, :conditions => {:public => true}) 
    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @custom_events }
    end
  end
  
end
  
  def admin_by_year
      if current_user.admin?     
         @custom_events = CustomEvent.find(:all, :order => 'year')
         @public_events = CustomEvent.find(:all, :conditions => {:public => true}, :order => 'year') 
        respond_to do |format|
          format.html # index.html.erb
          format.xml  { render :xml => @custom_events }
        end
    end
  end
end
