class MyDigi < ActiveRecord::Base
#has_and_belongs_to_many :custom_events
belongs_to :account
has_and_belongs_to_many :my_games
has_many :sequences, :order => "position"
has_many :custom_events, :through => :sequences, :order => "sequences.position"

scope :public, where('public', true )
#scope :mine, joins(:account) & Account.username
#scope :mine, where(:author => self.account.username )

def uses_event?(custom_event)
  self.custom_events.include?(custom_event)
  end
 
def unused_custom_events
  CustomEvent.find(:all) - self.custom_events
  end

def used_by_game?(my_digi)
  game.my_digis.include?(my_digi)
end

#def used_by_games
#logger.info "***********************************************************"
#self.account:  #{self.account}
#  @my_games = MyGame.find(:all, :conditions => [ :author => self.account.username])
#  @my_games.my_digis
#end

def non_attached_games
  logger.debug "self  #{self.inspect}"
  MyGame.find(:all, :conditions => {:author => self.author}) - self.my_games
end

#def public(user)
#end



end