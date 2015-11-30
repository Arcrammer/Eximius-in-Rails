class ListingsController < ApplicationController
  def all
    @listings = Listing.paginate page: params[:page], per_page: 15
    render 'listings/all'
  end
end
