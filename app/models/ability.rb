# frozen_string_literal: true

class Ability
  include CanCan::Ability

  def initialize(user)
    # Los visitantes no autenticados (guest)
    user ||= User.new

    if user.role_id==1
      can :manage, :all
    else
      can :read, User, id: user.id  
      can :update, User, id: user.id
    end
  end
end
