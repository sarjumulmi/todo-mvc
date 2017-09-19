
class SessionsController < ApplicationController

  def new

  end

  def create
    # raise "stp".inspect
    # raise auth_hash.inspect
    if auth_hash
      user = User.find_or_create_by_omniauth(auth_hash)
      session[:user_id] = user.id
      redirect_to root_path
      # if user = User.find_by(:email=>auth_hash['info']['email'])
      #   session[:user_id] = user.id
      # else
      #   user = User.new(:email=>auth_hash['info']['email'], :password=>SecureRandom.hex)
      #   if user.save
      #     session[:user_id] = user.id
      #     redirect_to root_path
      #   else
      #     render 'new'
      #   end
      # end
    else
      user = User.find_by(:email => params[:email])
      if user && user.authenticate(params[:password])
        session[:user_id] = user.id
        redirect_to root_path
      else
        render 'new'
      end
    end
  end

  def destroy
    reset_session
    redirect_to login_path
  end

  private
  def auth_hash
    request.env['omniauth.auth']
  end
end
