class Ability
  include CanCan::Ability

  def initialize(user)
    #can [:index], '/search/'
    can [:index,:show], Part 
    can [:show], Topic

    if user.is? :user
        can [:show,:new,:create], Topic
        can [:new, :create], Post
        can [:show,:edit,:update], User
    end

    if user.is? :moder
        can [:edit,:update,:destroy], Topic
    end

    if user.is? :admin
        can [:index], :Admin
        can [:index, :ban, :delete], User
        can [:new, :destroy, :create, :edit, :update], Part

    end

    #can :new, Topic if user.is? :user
        
    #can :create, Topic
    #can :index, SearchController if user.is? :admin

    #can :edit, Part if user.is? :admin

    #
    #user = User.find(session[:user_id]) if session[:user_id]    
    #can :part, :all if user.is? :admin
    #can :part, :destroy if user.is? :admin
    #can :post, :create, :new if user.is? :admin

    # Define abilities for the passed in user here. For example:
    #
    #   user ||= User.new # guest user (not logged in)
    #   if user.admin?
    #     can :manage, :all
    #   else
    #     can :read, :all
    #   end
    #
    # The first argument to `can` is the action you are giving the user permission to do.
    # If you pass :manage it will apply to every action. Other common actions here are
    # :read, :create, :update and :destroy.
    #
    # The second argument is the resource the user can perform the action on. If you pass
    # :all it will apply to every resource. Otherwise pass a Ruby class of the resource.
    #
    # The third argument is an optional hash of conditions to further filter the objects.
    # For example, here the user can only update published articles.
    #
    #   can :update, Article, :published => true
    #
    # See the wiki for details: https://github.com/ryanb/cancan/wiki/Defining-Abilities
end
end
