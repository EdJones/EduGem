class Ability
  include CanCan::Ability

  def initialize(user)
    user ||= User.new # guest user (not logged in)
    if user.admin
      can :manage, :all
    else
	  can :create, Account
      #can :read, :all
    end
  end
end