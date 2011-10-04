class EventSuggestionsController < ApplicationController
    before_filter :login_required, :except => [:login]
  #before_filter :authorized?, :except => [:login]
  
  # GET /event_suggestions
  # GET /event_suggestions.xml
  def index
    @event_suggestions = EventSuggestion.all

    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @event_suggestions }
    end
  end

  # GET /event_suggestions/1
  # GET /event_suggestions/1.xml
  def show
    @event_suggestion = EventSuggestion.find(params[:id])

    respond_to do |format|
      format.html { redirect_to  :controller => 'myAccount', :action => 'index' } # show.html.erb
      format.xml  { render :xml => @event_suggestion }
    end
  end

  # GET /event_suggestions/new
  # GET /event_suggestions/new.xml
  def new
    @event_suggestion = EventSuggestion.new

    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @event_suggestion }
    end
  end

  # GET /event_suggestions/1/edit
  def edit
    
    @event_suggestion = EventSuggestion.find(params[:id])

  end

  # POST /event_suggestions
  # POST /event_suggestions.xml
  def create
    @event_suggestion = EventSuggestion.new(params[:event_suggestion])
    @event_suggestion.user = current_account.username
    respond_to do |format|
      if @event_suggestion.save
        flash[:notice] = 'EventSuggestion was successfully created.'
        #format.html { redirect_to(@event_suggestion) }
        #format.html { redirect_to :controller => 'play',  :action => 'start'}
        format.html { redirect_to  :controller => 'myAccount', :action => 'index' }
        format.xml  { render :xml => @event_suggestion, :status => :created, :location => @event_suggestion }
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @event_suggestion.errors, :status => :unprocessable_entity }
      end
    end
  end

def thanks
  @response = EventSuggestion.find(params[:id])
end


  # PUT /event_suggestions/1
  # PUT /event_suggestions/1.xml
  def update
    @event_suggestion = EventSuggestion.find(params[:id])

    respond_to do |format|
      if @event_suggestion.update_attributes(params[:event_suggestion])
        flash[:notice] = 'EventSuggestion was successfully updated.'
        format.html { redirect_to(@event_suggestion) }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @event_suggestion.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /event_suggestions/1
  # DELETE /event_suggestions/1.xml
  def destroy
    @event_suggestion = EventSuggestion.find(params[:id])
    @event_suggestion.destroy

    respond_to do |format|
      #format.html { redirect_to(event_suggestions_url) }
      format.html { redirect_to  :controller => 'myAccount', :action => 'index' }
      format.xml  { head :ok }
    end
  end
  
  
  private
    #  only allow Ed to access
   def admin?
    logged_in? &&  current_user.login == "ej0c"
 end
end
