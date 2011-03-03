class Event < ActiveRecord::Base
      #acts_as_authorizable

  validates_presence_of :idee, :title, :year
  validates_numericality_of :idee, :year
  validates_uniqueness_of :idee
  
def self.sortable_events
    find(:all)
  end
  
def self.sorted_events
  find(:all, 
          :conditions => "idee != nil",
          :order => "idee")
        end
        
 def setNewIdee(newIdee)
self[:idee] = newIdee
end
end
