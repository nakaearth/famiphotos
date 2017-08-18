# frozen_string_literal: true
require 'rails_helper'

RSpec.describe Album, type: :model do
  let!(:user) { create(:user) }
  let(:album) { create(:album, user: user) }

  describe '幾つかのテーブルと関連を持っている' do
    context 'have a relation tro user class' do
      it { expect belong_to(:album) }
    end
  end

  describe '入力チェックをする' do
    context 'passwordカラム' do
      # it { is_expected.to validate_length_of(:password).is_at_most(30) }
    end
  end
end
