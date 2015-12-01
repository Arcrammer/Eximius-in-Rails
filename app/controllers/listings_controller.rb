class ListingsController < ApplicationController
  def all
    @listings = Listing
      .order('created_at DESC')
      .joins(:business)
      .paginate page: params[:page], per_page: 15
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
        # yet signed in to the app=
        flash[:needs_employer_status] = true
        redirect_to '/profile'
      end
    else
      # The user hasn't authenticated
      redirect_to '/auth/login'
    end
  end

  def persist
    unless session[:user_id].blank?
      user = User.find(session[:user_id])
      # The user has authenticated
      listing = Listing.new(params.require(:listing).permit([
        :title,
        :location
      ]))

      # Save the listing body to the filesystem
      listing.body_filename = (0...50).map { ('a'..'z').to_a[rand(26)] }.join + '.html'
      File.open(Rails.root.join('public', 'listing_bodies', listing.body_filename), 'wb') do |f|
        f.write(params[:listing][:listing_body])
      end

      # Find or create the business name for the foreign table
      business = Business.where(business: params[:listing][:business_name]).take
      if business.nil?
        # There isn't a business in the database
        # with the name provided by the listing
        # creator yet, so we'll create it
        listing.business_id = Business.create(business: params[:listing][:business_name]).id
      else
        # The database already contains a business
        # with the name provided by the listing
        # creator, so we'll use its' ID
        listing.business_id = business.id
      end
      # Save the listing to the database
      # with links to its' assets
      listing.save

      redirect_to '/listings'
    else
      # The user hasn't authenticated
      redirect_to '/auth/login'
    end
  end
end
