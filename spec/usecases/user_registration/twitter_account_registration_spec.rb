# frozen_string_literal: true

require 'rails_helper'

RSpec.describe UserRegistration::TwitterAccountRegistration do
  describe '.call' do
    let(:organization) { create(:organization) }

    context 'paramsの値をusersテーブルに登録する値が渡って来た場合' do
      let(:params) do
        {
          provider: 'twitter',
          uid: '12345667',
          info: {
            email: 'test@gamil',
            name: 'テスト太郎',
            nickname: 'jbloggs',
            image: 'http://graph.facebook.com/1234567/picture?type=square'
          },
          credentials: {
            token: 'ABCDEF...', # OAuth 2.0 access_token, which you may wish to store
            secret: '123ABCDEF...' # OAuth 2.0 access_token, which you may wish to store
          }
        }
      end

      before do
        @user = UserRegistration::TwitterAccountRegistration.call(params)
      end

      it 'パラメータで渡された値でUser登録される' do
        expect(@user.provider).to eq params[:provider]
        expect(@user.name).to eq params[:info][:name]
        expect(@user.email).to eq params[:info][:email]
        expect(@user.image_url).to eq params[:info][:image]
        expect(@user.nickname).to eq params[:info][:nickname]
        expect(@user.access_token).to eq params[:credentials][:token]
        expect(@user.secret_token).to eq params[:credentials][:secret]
      end
    end

    context '不正なパラメータが渡って来た場合' do

      it '例外を出力する' do
      end
    end
  end
end
