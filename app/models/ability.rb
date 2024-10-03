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
    when 'guest'
      can :read, HomeController, :index # Allow guests to access the index action of HomeController
      can :read, Story, is_approved: true
      cannot :read, Comment
    end
  end
end
