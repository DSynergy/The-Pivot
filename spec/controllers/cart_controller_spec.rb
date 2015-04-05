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
    it "successfully adds item to cart" do
      request.env["HTTP_REFERER"] = "/cart"
      item = create(:item)
      post :create, {item_id: item}
      expect(session[:cart][item.id.to_s]).to eq(1)
    end
  end
end
