# users_controller.rb
#
# Eximius
# Alexander Rhett Crammer
# Advanced Server-Side Languages
# Full Sail University
# Created Wednesday, 25 Nov. 2015
#
class UsersController < ApplicationController

  def profile
    if session[:user_id].blank?
      redirect_to '/'
    else
      @user = User.find(session[:user_id])
      render 'users/profile', layout: false
    end
  end

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
    if !params[:user].blank?
      user = User.where("username = ?", params[:user][:username])[0]
      if user.authenticate(params[:user][:password])
        # The user has been authenticated
        session[:user_id] = user.id
        redirect_to '/'
      else
        # The user provided incorrect credentials
        flash[:wrong_password] = true
      end
    end
  end

  def logout
    session[:user_id] = nil
    redirect_to '/'
  end
end
