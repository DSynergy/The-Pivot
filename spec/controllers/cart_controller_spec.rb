require 'rails_helper'

RSpec.describe CartController, type: :controller do
  describe "GET #index" do
    it "responds successfully with an HTTP 200 status code" do
      get :index
      expect(response).to be_success
      expect(response).to have_http_status(200)
    end
  end

  describe "POST #create" do
    it "successfully adds item to cart" do
      request.env["HTTP_REFERER"] = "/cart"
      item = create(:item)
      post :create, {item_id: item}
      expect(session[:cart][item.id.to_s]).to eq(1)
    end
  end
end
