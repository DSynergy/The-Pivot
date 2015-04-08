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
      listing = create(:listing, available_dates: {"1"=>"2", "1"=>"3"})
      post :create, {listing_id: listing, :listing => {"start_date" => {"1"=>"2"}, "end_date" => {"1"=>"3"} } }
      expect(session[:cart][listing.id.to_s]).to eq([[{"1"=>"2"}, {"1"=>"3"}]])
    end
  end

end
