class Sequence < ActiveRecord::Base
  belongs_to :custom_event
  belongs_to :my_digi
  acts_as_list :scope => :my_digi
  default_scope :order => "position"
  
#    alias :old_initialize :initialize
#  def initialize(attributes = nil)
#    old_initialize(attributes)
#    # Do whatever you want in here.
#        logger.info "++++++++++++++++++++++++++Sequence.initialize line 9++++++++++++++++++++++++++++++++++++"
#    position = Sequence.last.position
#    count = Sequence.find(:all, :conditions =>  {:my_digi_id => self.my_digi.id}).length

#    logger.debug "count:  #{count}"
#    self.position = count +1
#  end

  #def initialize(args = nil)
    logger.info "++++++++++++++++++++++++++Sequence.after_initialize line 20++++++++++++++++++++++++++++++++++++"
    #position = Sequence.last.position
    #logger.debug "position  #{position}"
    #Sequence.last.update_attributes(:position =>  Sequence.last.length )
#@position = '14'
  #end
  
end
