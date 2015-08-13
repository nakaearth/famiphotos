require 'rails_helper'

describe User, type: :model do
  let!(:user) { User.with_writable { create(:user) } }

  describe 'association' do
    context 'have a relation to user class' do
      it { expect have_many(:group_members) }
    end

    context 'have a relation to user class' do
      it { expect have_many(:photos) }
    end
  end

  describe 'Validation' do
    context 'name column' do
      it { expect validate_presence_of(:name) }
      it { expect validate_length_of(:name).is_at_most(60) }
    end

    context 'uid column' do
      it { expect validate_presence_of(:uid) }
    end

    context 'email column' do
      it { expect validate_length_of(:email).is_at_most(60) }
    end

    context 'provider column' do
      it { expect validate_presence_of(:provider) }
      it { expect validate_length_of(:email).is_at_most(10) }
    end
  end
end
