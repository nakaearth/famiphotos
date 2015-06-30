require 'rails_helper'

RSpec.describe PhotosController, type: :controller do
  render_views

  let(:user) { create(:user) }
  let(:photo_list) { create(:photo,  user: user) }

  before do
    allow(controller) .to receive(:current_user) { user }
    allow(controller) .to receive(:login?) { true }
  end

  describe "GET #index" do
    before do
      get :index
    end

    it "returns http success" do
      expect(response).to have_http_status(:success)
    end

    it { expect(assigns[:photos]).not_to be_nil }
    it { expect(assigns[:photos].size).to eq 1 }
  end

  describe "GET #show" do
    it "returns http success" do
      get :show
      expect(response).to have_http_status(:success)
    end
  end

  describe "GET #new" do
    it "returns http success" do
      get :new
      expect(response).to have_http_status(:success)
    end
  end

  describe "GET #create" do
    before do
      Paperclip::Attachment.any_instance.stubs(:save).returns(true)
    end

    it "returns http success" do
      get :create
      expect(response).to have_http_status(:success)
    end
  end

  describe "GET #edit" do
    it "returns http success" do
      get :edit
      expect(response).to have_http_status(:success)
    end
  end

  describe "GET #update" do
    it "returns http success" do
      get :update
      expect(response).to have_http_status(:success)
    end
  end

  describe "GET #destroy" do
    it "returns http success" do
      get :destroy
      expect(response).to have_http_status(:success)
    end
  end
end
