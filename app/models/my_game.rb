class MyGame < ActiveRecord::Base
  has_and_belongs_to_many :my_digis
  
  def uses_digi?(my_digi)
  self.my_digis.include?(my_digi)
  end
 
def unused_my_digis(user)
  MyDigi.find(:all, :conditions => { :author => user }) - self.my_digis
  end
  
  def public_digis
    MyDigi.find(:all, :conditions => {:public => true })
  end
  
def unused_public_my_digis(user)
  logger.info "line 17"
  #logger.debug "@self.my_digis #{self.my_digis}"
  self.public_digis - self.unused_my_digis(user)
  end  
end
