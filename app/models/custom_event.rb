class CustomEvent < ActiveRecord::Base
#has_and_belongs_to_many :my_digi
  validates_presence_of :idee, :title, :year
  validates_numericality_of :idee, :year
  validates_uniqueness_of :idee
has_many :sequences, :order => "position"
has_many :my_digis, :through => :sequences
acts_as_list :scope => :my_digi


    alias :old_initialize :initialize
  def initialize(attributes = nil)
    old_initialize(attributes)
    # Do whatever you want in here.
    logger.debug "CustomEvent.last.idee  #{CustomEvent.last.idee}"
    self.idee = CustomEvent.last.id + 1000

  end

   def didji_position(my_digi_id)
    logger.info "entering custom_event.digi_position"
     #my_digi_id = MyDigi.find(params[:id])
     #sequence = Sequence.find(:all, :conditions => {:my_digi_id =>  my_digi_id, :custom_event_id =>  id } )
     sequence = Sequence.find(:all, :conditions => {:my_digi_id =>  my_digi_id, :custom_event_id => self.id } )
     logger.debug "sequence  #{sequence.inspect}"
     sequence[0].position
     end
#def position(digi)
#  @sequence = Sequence.find(:all, :conditions => {:custom_event_id => self.id, :my_digi_id => digi.id})
#  logger.debug "@sequence  #{@sequence[0].position}"
#  position = @sequence[0].position
#  end


end
