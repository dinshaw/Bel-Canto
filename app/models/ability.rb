class Ability
  include CanCan::Ability

  def initialize(user)
    if user.super_user?
      can :manage, :all
    elsif user.admin?
      can :manage, :cms_pages
      can :read, :all
    else
      can :read, :all
    end

    can :update, User, :id => user.id
  end
end