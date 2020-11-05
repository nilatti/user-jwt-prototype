
class User < ApplicationRecord
  has_secure_password


  def self.handle_login(email, password)
    user = User.find_by(email: email.downcase)
    if user && user.authenticate(password)
      user_info = Hash.new
      user_info[:token] = CoreModules::JsonWebToken.encode({user_id: user.rand_token}, 4.hours.from_now)
      user_info[:user_id] = user.id
      return user_info
    else
      return false
    end
  end


    def new_token
      rand = ('a'..'z').to_a.shuffle[0,8].join
      self.rand_token = rand
      self.save
    end


end
