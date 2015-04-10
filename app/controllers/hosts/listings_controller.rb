class Hosts::ListingsController < ApplicationController

    before_action :set_listing, only: [:update, :show, :edit, :destroy]
    before_action :redirect_to_login_if_not_logged_in

    def index
      @listings = Listing.all
    end

    def edit
    end

    def update
      if @listing.update(listing_params)
        redirect_to host_path(current_user)
        flash[:notice] = "Successfully Updated"
      else
        flash[:notice] = @listing.errors.empty? ? "Listing did not update" : @listing.errors.full_messages.to_sentence
        render :edit
      end
    end

    def new
      @listing = Listing.new
    end

    def show
    end

    def create
      @listing = Listing.new(listing_params)
      if @listing.save
        current_user.listings << @listing
        flash[:notice] = "Listing saved!"
        redirect_to host_path(current_user)
      else
        flash[:notice] = "That listing already exists!!"
        redirect_to host_path(current_user)
      end
    end

    def destroy
      if @listing.destroy
        flash[:notice] = "Listing Deleted"
        redirect_to host_path(current_user)
      else
        flash[:notice] = "Uh oh, something went wrong"
        render :edit
      end
    end

    private

    def listing_params
      params.require(:listing).permit(:title, :description, :private_bathroom,
      :price, :quantity_available, :people_per_unit, :status, :street_address, :city,
      :state, :country, :zipcode, :start_date, :end_date, :avatar, :remote_avatar_url)
    end

    def set_listing
      @listing = Listing.find(params[:id])
    end
    
end
