class Ability
  include CanCan::Ability

  def initialize(user)
    user ||= User.new # guest user (not logged in)
    if user.admin
      can :manage, :all
	else if user.author
	  can :manage, MyDidji, :author => current_user
	  can :read, MyDidji, :public => true
    else
	  can :create, Account
    end
  end
end
end