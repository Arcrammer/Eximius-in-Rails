# users_controller.rb
#
# Eximius
# Alexander Rhett Crammer
# Advanced Server-Side Languages
# Full Sail University
# Created Wednesday, 25 Nov. 2015
#
class UsersController < ApplicationController
  def create
    @user = User.new
  end

  def persist
    @user = User.new(params.require(:user).permit([
      :username,
      :email_address,
      :password,
      :password_confirmation,
      :is_employer,
      :is_seeker
    ]))
    if @user.save
      flash[:user_created] = true
      session[:user_id] = @user.id
      redirect_to '/'
    else
      flash[:user_created] = false
      flash[:creation_probs] = @user.errors.to_a
      render 'users/create'
    end
  end

  def login
    user = User.where("username = ?", params[:user][:username])[0].attributes
    @userr = user
    @userr = BCrypt::Engine.hash_secret(user['username'], user['password_digest'])
    # unless BCrypt::Engine.hash_secret(params[:user][:username], user.password_digest)
      # session[:user_id] = user.id
      # redirect_to '/'
    #   true
    # else
    #   false
    # end
    # redirect_to '/'
  end

  def logout
    session[:user_id] = nil
    redirect_to '/'
  end
end
