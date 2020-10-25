module Types
  class QueryType < Types::BaseObject
    field :users, [Types::UserType], null: false, description: "Returns a list of users"
    field :me, Types::UserType, null: true

    def users
      User.all
    end
    def me
      context[:current_user]
    end
  end
end
