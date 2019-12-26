# frozen_string_literal: true
require 'rails_helper'

RSpec.describe Group, type: :model do
  describe '幾つかのテーブルと関連を持っている' do
    context 'have a relation tro user class' do
      it { expect belong_to(:user) }
    end
  end

  describe '入力チェックをする' do
    context 'nameカラム' do
      it { is_expected.to validate_length_of(:name).is_at_most(80) }
    end
  end
end
