class ListingsController < ApplicationController
  def all
    @listings = Listing.paginate page: params[:page], per_page: 15
    render 'listings/all'
  end

  def create
    unless session[:user_id].blank?
      user = User.find(session[:user_id])
      # The user has authenticated
      if user.is_employer
        render 'listings/create'
      else
        # The user is trying to create
        # a post although they haven't
        # yet signed in to the app
        flash[:needs_employer_status] = true
        redirect_to '/profile'
      end
    else
      # The user hasn't authenticated
      redirect_to '/auth/login'
    end
  end
end
