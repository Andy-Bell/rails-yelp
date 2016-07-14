class Ability
  include CanCan::Ability

  def initialize(user)
    # Define abilities for the passed in user here. For example:

    user ||= User.new # guest user (not logged in)
      can :read, :all
      if user.id
        can :read, User, id: user.id
        can :create, Restaurant
        can :delete, Restaurant, user_id: user.id
        can :update, Restaurant, user_id: user.id
        can :create, Review
        cannot :create, Review, :restaurant => { :user_id => user.id}
        # cannot :manage, Review do |review|
        #   owner_id = Restaurant.find(review.restaurant_id).user_id
        #   owner_id == user.id
        # end
      end

      # The first argument to `can` is the action you are giving the user
    # permission to do.
    # If you pass :manage it will apply to every action. Other common actions
    # here are :read, :create, :update and :destroy.
    #
    # The second argument is the resource the user can perform the action on.
    # If you pass :all it will apply to every resource. Otherwise pass a Ruby
    # class of the resource.
    #
    # The third argument is an optional hash of conditions to further filter the
    # objects.
    # For example, here the user can only update published articles.
    #
    #   can :update, Article, :published => true
    #

  end
end
