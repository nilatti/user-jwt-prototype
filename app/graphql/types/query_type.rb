module Types
  class QueryType < Types::BaseObject
    field :users, [Types::UserType], null: false, description: "Returns a list of users"
    field :me, Types::UserType, null: true
    field :theater, Types::TheaterType, null: true
    field :theaters, [Types::TheaterType], null: true
    field :theater_connection, Types::TheaterConnectionType, null: true
    #do
      # puts "resolving connection"''
      # resolve ->(_obj, _args, _ctx) {
      #   Theater.all.order(args[:order_by])
      # }
    # end
    def me
      if context[:current_user]
        return context[:current_user]
      end
    end
    def theaters
      Theater.all
    end
    def theater_connection
      Theater.all
    end
    def users
      User.all
    end

  end
end
