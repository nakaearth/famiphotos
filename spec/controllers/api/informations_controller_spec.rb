require 'rails_helper'

RSpec.describe Api::InformationsController, type: :controller do
  render_views

  let(:information) { create_list(:information, 5) }

  describe 'GET #index' do
    before do
      get :index
    end

    it "returns http success" do
      expect(response).to have_http_status(:success)
    end

    it { expect(assigns[:informations].size).to eq 5 }
  end

  describe 'Post #create' do
    before do
      post :create, describe: 'hoge'
    end
  end
end
