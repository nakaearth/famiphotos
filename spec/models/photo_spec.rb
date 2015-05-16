require 'rails_helper'

RSpec.describe Photo, type: :model do
  let(:user) { create(:user) }
  let(:photo) { create(:photo, user: user) }

  describe 'association' do
    context 'have a relation to photo class' do
      it { expect belong_to(:user) }
    end
  end

  describe 'validation' do
    context 'description column' do
      it { expect ensure_length_of(:descripton).is_at_most(140) }
    end
  end
end
