module Mutations
  class SignOutMutation < Mutations::BaseMutation
    field :user, Types::UserType, null: true
    field :message, String, null: true

    def resolve
      user = context[:current_user]
      if user.present?
        user.new_token
        return {message: "Signed out via mutation!", errors: user.errors}
      else
        GraphQL::ExecutionError.new("User not signed in")
      end
    end
  end
end
