module Mutations
  class SignInMutation < Mutations::BaseMutation
    argument :email, String, required: true
    argument :password, String, required: true

    field :token, String, null: true
    field :user, Types::UserType, null: true

    def resolve(email:, password:)
      user = User.find_by!(email: email)
      return {} unless user
      { user: user }
    end
  end
end
