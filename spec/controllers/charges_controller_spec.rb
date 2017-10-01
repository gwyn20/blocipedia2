require 'rails_helper'

RSpec.describe ChargesController, type: :controller do

  describe "GET #new" do
    it "returns http success" do
      get :new
      expect(response).to have_http_status(:success)
    end
  end

  describe "GET #downgrade" do
    it "returns http success" do
      get :downgrade
      expect(response).to have_http_status(:success)
    end
  end

end
