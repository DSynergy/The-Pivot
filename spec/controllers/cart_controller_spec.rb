require 'rails_helper'

RSpec.describe CartsController, type: :controller do
  describe "GET #index" do
   xit "responds successfully with an HTTP 200 status code" do
      get :index
      expect(response).to be_success
      expect(response).to have_http_status(200)
    end
  end

  describe "POST #create" do
    it "successfully adds listing to cart" do
      request.env["HTTP_REFERER"] = "/cart"
      listing = create(:listing, available_dates: {"1"=>"2"})
      post :create, {listing_id: listing}
      expect(session[:cart][listing.id.to_s]).to eq(1)
    end
  end

  describe "POST #update" do
    it "successfully updates cart with listing" do
    end
  end
end
