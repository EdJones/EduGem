class Invite < ActiveRecord::Base
  before_create :generate_token
has_one :recipient, :class_name => 'User'
#accepts_role :inviter
validates_presence_of :to
#validate :recipient_is_not_registered

private
def generate_token
  self.token = Digest::SHA1.hexdigest([Time.now, rand].join)
end

def recipient_is_not_registered
  errors.add :to, 'is already registered' if User.find_by_email(:to)
end

end
