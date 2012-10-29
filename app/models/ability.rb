class Ability
  include CanCan::Ability

  def initialize(user)
    can [:index], :Search
    can [:index,:show], Part 
    can [:show], Topic

    if user.is? :user
        can [:comment], :All
        can [:index], :Newpost
        can [:new, :create], Comment
        can [:show,:new,:create], Topic
        can [:new, :create], Post
        can [:edit, :update], Post, :user_id=>user.id
        can [:show,:edit,:update, :sing_out], User, :id=>user.id
    end

    if user.is? :moder
        can [:edit, :update, :destroy], Comment
        can [:edit, :update, :destroy], Topic
        can [:edit, :update, :destroy], Post
    end

    if user.is? :admin
        can [:index], :Admin
        can [:index, :change_role, :destroy], User
        can [:new, :destroy, :create, :edit, :update], Part
        can [:edit, :update], Post
        can [:show, :edit, :update], User
    end

    if user.is? :banned
        cannot [:comment], :All
        cannot [:new, :create], Post
        cannot [:new, :create], Topic
        cannot [:new, :create], Post
    end
    
  end

end
