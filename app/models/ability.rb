class Ability
    include CanCan::Ability

    def initialize(admin)
        # Define abilities for the passed in user here. For example:
        #
        admin ||= Admin.new # guest user (not logged in)

        if admin.is_a? Admin
            if admin.has_role? :super_admin
                can :manage, :all
            elsif admin.has_role? :admin
                can :manage, [Student, Event, Ticket]
                cannot :checkout_all, Event
            elsif admin.has_role? :gatekeeper
                can :manage, [Student, Ticket]
                can [:index, :autocomplete_event_name], Event
            end
        end
        #
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
        # See the wiki for details:
        # https://github.com/CanCanCommunity/cancancan/wiki/Defining-Abilities
    end
end
