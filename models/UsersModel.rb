require 'bcrypt'
class UsersModel < ActiveRecord::Base
  # student.name
  # student.email
  self.table_name = 'users'
  include BCrypt
  def password=(password)
    self.password_digest = BCrypt::Password.create(password)
  end

  def password
    BCrypt::Password.new(self.password_digest)
  end

  def self.authenticate(user_name, password)
    user = UsersModel.find_by(user_name: user_name)
    return user if user.password == password
  end


end
