class Ability
  include CanCan::Ability

  def initialize(user)
    user ||= User.new(role: 'guest') # guest user OR not logged in

    Rails.logger.debug "User Role in Ability: #{user.role.inspect}"

    case user.role
    when 'admin'
      can :manage, :all
    when 'user'
      can :read, Story, is_approved: true
      can :read, Comment
      can [:save, :unsave], Story, is_approved: true
    when 'guest'
      can :read, HomeController, :index
      can :read, Story, is_approved: true
      can [:save, :unsave], Story, is_approved: true
      cannot :read, Comment
    end
  end
end
