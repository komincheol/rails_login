class UserController < ApplicationController
  def index
    if session[:user_id]
      @email= User.find(session[:user_id]).email
    end
  end

  def new
  end

  def create
    require 'digest'
    @email=params[:user_email]
    @password=params[:user_password]
    @user_name=params[:user_name]
    hidden_password = Digest::MD5.hexdigest(@password)
    User.create(
      email: @email,
      password: hidden_password,
      name: @user_name
      )
  end
  
  def login
  
  end
  
  def login_process
    require 'digest'
    if User.exists?(email: params[:user_email])
      user=User.find_by(email: params[:user_email])
      if user.password == Digest::MD5.hexdigest(params[:user_password])
        session[:user_id]=user.id
        redirect_to '/'
      end
    end
  end
end
