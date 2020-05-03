class Ability
  include CanCan::Ability

  def initialize(user)
    if user 
      user.admin? ? admin_abilities : user_abilities(user) 
    else  
      guest_abilities
    end  
  end

  def guest_abilities
    can :read, :all
  end

  def admin_abilities
    can :manage, :all
  end

  def user_abilities(user)
    guest_abilities
    can :create, [Question, Answer, Comment]
    can :destroy, [Question, Answer, Comment], user: user
    can :update, [Question, Answer, Comment], user: user
  end 
end
