require 'rails_helper'

describe User, type: :model do
  let!(:user) { create(:user) }

  describe '幾つかのテーブルと関連を持っている' do
    context 'have a relation to user class' do
      it { expect have_many(:group_members) }
    end
  end

  describe '入力チェックをする' do
    context 'nameカラム' do
      it { expect validate_presence_of(:name) }
      it { expect ensure_length_of(:name).is_at_most(60) }
    end

    context 'uidカラム' do
      it { expect validate_presence_of(:uid) }
    end

    context 'emailカラム' do
      it { expect ensure_length_of(:email).is_at_most(60) }
    end

    context 'providerカラム' do
      it { expect validate_presence_of(:provider) }
      it { expect ensure_length_of(:email).is_at_most(10) }
    end
  end
end
