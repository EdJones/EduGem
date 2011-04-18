class PracticeController < ApplicationController
  
  
    def index
    @my_digis = MyDigi.find(:all, :conditions => { :public_play => true })

    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @my_digis }
    end
  end
  

  # GET /my_digis/1
  # GET /my_digis/1.xml
  def show
    visitor = Traffic.create(:ip => request.remote_ip, :didji => (params[:id]))
    #@my_digi.custom-events may not be sorted by idee. Should this be changed in model or here?
    @events = CustomEvent.find(:all, 
          :order => "idee")
    @my_digi = MyDigi.find(params[:id])
    @eventsSourceList = @my_digi.custom_events
    @eventsStartIdee = @my_digi.custom_events.first.idee
        @eventsEndIdee = @my_digi.custom_events.last.idee
        #logger.debug "@my_digi.custom_events.length #{@my_digi.custom_events.length}"
        @eventsTimeBase = @events[0..5]
    #logger.debug "@eventsSourceList #{@eventsSourceList.inspect}"
   #redirect_to :action => :custom_events,  :id => @my_digi
   #for buttons to other didgis:
   @didjis = MyDigi.find(:all, :conditions => { :public_play => true }) - MyDigi.find(:all, :conditions => {:id => '13'})
   @possible_score = 0
   @eventsSourceList.each do |e| @possible_score = @possible_score + e.pointValue end 
     logger.debug "@possible_score #{@possible_score}"
  end
end
