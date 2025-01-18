# frozen_string_literal: true

class Ability
  include CanCan::Ability

  def initialize(user)
    # Los visitantes no autenticados (guest)
    user ||= User.new

    if user.role_id == 1
      can :manage, :all
    elsif user.role_id == 2
      can :read, :all
      can :edit, :all
      can :update, User do |other_user|
        other_user.id == user.id || other_user.role_id != 1
      end
      cannot :create, User, role_id: 1
    elsif user.role_id == 3
      can :read, User, id: user.id
      can :update, User, id: user.id

      can :manage, Product
      can :manage, Sale
      cannot :index, User
    end
  end
end