require 'rails_helper'

RSpec.describe CartsController, type: :controller do
  describe "GET #index" do
   it "responds successfully with an HTTP 200 status code" do
      get :show
      expect(response).to be_success
      expect(response).to have_http_status(200)
    end
  end

  describe "POST #create" do
    it "successfully adds listing to cart" do
      request.env["HTTP_REFERER"] = "/cart"
      listing = create(:listing, start_date: "01/02/15", end_date: "01/03/15")
      post :create, {listing_id: listing, :listing => {"start_date" => "01/02/15", "end_date" => "01/04/15"}}
      expect(session[:cart][listing.id.to_s]).to eq(["01/02/15", "01/04/15"])
    end
  end

end
