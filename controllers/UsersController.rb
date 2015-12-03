class UsersController < ApplicationController

  # does username exist?
  def does_user_exist(username)
    user = UsersModel.find_by(:user_name => username.to_s)
    if user
      return true
    else
      return false
    end
  end

  # registration
  get '/register' do
    erb :users_register
  end

  post "/register" do

    if self.does_user_exist(params[:user_name]) == true
      erb :users_already_exists
    end
    # generate a salt and hash to use
    user = UsersModel.new(user_email: params[:user_email], user_name: params[:user_name],password: params[:password])
    # password_salt = BCrypt::Engine.generate_salt
    # password_hash = BCrypt::Engine.hash_secret(params[:password], password_salt)

    # new_user = UsersModel.new
    # new_user.user_name = params[:user_name]
    # new_user.user_email = params[:user_email]
    # new_user.password_salt = password_salt
    # new_user.password_hash = password_hash
    # new_user.is_admin = false

    user.save

    session[:current_user] = user

    erb :users_register_confirmation

  end

  #login
  get '/login' do
    erb :users_login
  end

  post "/login" do
    #binding.pry
    if self.does_user_exist(params[:user_name]) == true
      p 'user exists'
      user = UsersModel.where(:user_name => params[:user_name]).first
      p user
      binding.pry
      if UsersModel.authenticate(params[:user_name], params[:password])
        session[:current_user] = user
        redirect "/"
      end
    end
    erb :users_login_error
  end

  get "/logout" do
    session[:current_user] = nil
    redirect "/"
  end

end
