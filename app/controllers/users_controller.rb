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

  def update
    user = User.find(session[:user_id])
    selfie = params[:user][:selfie]
    cv = params[:user][:cv]

    # Basic settings
    user.username = params[:user][:username]
    user.email_address = params[:user][:email_address]
    user.is_employer = params[:user][:is_employer]
    user.is_seeker = params[:user][:is_seeker]

    # File uploads
    unless selfie.nil?
      # The user has uploaded another
      # selfie; Save it to the server
      local_filename = (0...50).map { ('a'..'z').to_a[rand(26)] }.join + File.extname(selfie.original_filename)
      File.open(Rails.root.join('public', 'selfies', local_filename), 'wb') do |s|
        if s.write(selfie.read)
          unless user.selfie_filename.blank?
            # The new selfie was saved; Delete the old one
            File.delete Rails.root.join('public', 'selfies', user.selfie_filename)
          end
        end
      end
      user.selfie_filename = local_filename
    end

    unless cv.nil?
      # The user has uploaded another
      # résumé; Save it to the server
      local_filename = (0...50).map { ('a'..'z').to_a[rand(26)] }.join + File.extname(cv.original_filename)
      File.open(Rails.root.join('public', 'résumés', local_filename), 'wb') do |r|
        if r.write(cv.read) && !user.cv_filename.nil?
          # The new résumé was saved; Delete the old one
          File.delete Rails.root.join('public', 'résumés', user.cv_filename)
        end
      end
      user.cv_filename = local_filename
    end

    # We're done so we'll save the new data
    user.save
    redirect_to '/profile'
  end

  def persist
    user = User.new(params.require(:user).permit([
      :username,
      :email_address,
      :password,
      :password_confirmation,
      :is_employer,
      :is_seeker
    ]))
    selfie = params[:user][:selfie]
    cv = params[:user][:cv]

    # File uploads
    if selfie.nil?
      # Friendly reminder that the value
      # simply doesn't come if there's
      # no image uploaded, so we'll check
      # for 'nil' instead of 'blank'
      user.selfie_filename = nil
    else
      # Attempt saving their selfie
      # to the servers' filesystem
      local_filename = (0...50).map { ('a'..'z').to_a[rand(26)] }.join + File.extname(selfie.original_filename)
      File.open(Rails.root.join('public', 'selfies', local_filename), 'wb') do |s|
        s.write(selfie.read)
      end
      user.selfie_filename = local_filename
    end
    if cv.nil?
      user.cv_filename = nil
    else
      # Attempt saving their résumé
      # to the servers' filesystem
      local_filename = (0...50).map { ('a'..'z').to_a[rand(26)] }.join + File.extname(cv.original_filename)
      File.open(Rails.root.join('public', 'résumés', local_filename), 'wb') do |s|
        s.write(cv.read)
      end
      user.cv_filename = local_filename
    end

    # We're done so we'll save the new data
    if user.save
      flash[:user_created] = true
      session[:user_id] = user.id
      redirect_to '/'
    else
      flash[:user_created] = false
      flash[:creation_probs] = user.errors.to_a
      render 'users/create'
    end
  end

  def login
    unless params[:user].blank?
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
