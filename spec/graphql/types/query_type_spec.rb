require "rails_helper"

RSpec.describe Types::QueryType do
  describe "users" do
    let!(:users) { create_pair(:user) }

    let(:query) do
      %(query {
        users {
          email
        }
      })
    end

    subject(:result) do
      UserJwtPrototypeSchema.execute(query).as_json
    end

    it "returns all users" do
      expect(result.dig("data", "users")).to match_array(
        users.map { |user| { "email" => user.email } }
      )
    end
  end
end
