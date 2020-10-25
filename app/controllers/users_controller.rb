class UsersController  < ApplicationController
  before_action do
    authenticate_cookie
  end

  def show
    render json: current_user
  end
end
