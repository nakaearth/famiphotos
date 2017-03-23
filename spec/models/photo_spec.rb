require 'rails_helper'

RSpec.describe Photo, type: :model do
  let!(:user) { create(:user) }
  let!(:photo) { create(:photo, user: user) }

  describe '幾つかのテーブルと関連を持っている' do
    context 'have a relation tro user class' do
      it { expect have_many(:tags) }
      it { expect belong_to(:user) }
      it { expect belong_to(:album) }
    end
  end

  describe '入力チェックをする' do
    context 'descriptionカラム' do
      it { is_expected.to validate_length_of(:description).is_at_most(140) }
    end
  end
end
