class ApplicationController < ActionController::API
  include ActionController::Cookies

  def authenticate_cookie
    if params[:query].include?('SIGN_IN_MUTATION') #when switch to react front end, maybe need to swithc this to using operation name
      sign_in(params[:variables]["email"], params[:variables]["password"])
      return true
    end

    token = cookies.signed[:jwt]
    decoded_token = CoreModules::JsonWebToken.decode(token)
    if decoded_token
      user = User.find_by(rand_token: decoded_token["user_id"])
    end
    if user
      return true
    else
      return false
    end
    # if user then return true else render json: {status: 'unauthorized', code: 401} end
  end

  def current_user
    token = cookies.signed[:jwt]
    decoded_token = CoreModules::JsonWebToken.decode(token)
    if decoded_token
      user = User.find_by(rand_token: decoded_token["user_id"])
    end
    if user
      return user
    else
      return false
    end
  end

  def sign_in(email, password)
    if email && password
      login_hash = User.handle_login(email, password)
      if login_hash
        cookies.signed[:jwt] = {value:  login_hash[:token], httponly: true}
        user = User.find_by(id: login_hash[:user_id])
        if user
          return user
        else
          return false
        end
      else
        render json: {status: 'incorrect email or password', code: 422}
      end
    else
      render json: {status: 'specify email address and password', code: 422}
    end
  end
end
