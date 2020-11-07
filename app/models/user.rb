
class User < ApplicationRecord
  has_secure_password

  after_create :new_token

  def self.handle_login(email, password)
    user = User.find_by(email: email.downcase)
    if user && user.authenticate(password)
      return user.login_hash
    else
      return false
    end
  end

  def new_token
    rand = ('a'..'z').to_a.shuffle[0,8].join
    self.rand_token = rand
    self.save
  end

  def login_hash
    user_info = Hash.new
    user_info[:token] = CoreModules::JsonWebToken.encode({user_id: self.rand_token}, 4.hours.from_now)
    user_info[:user_id] = self.id
    return user_info
  end


end
