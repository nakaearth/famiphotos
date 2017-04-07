# frozen_string_literal: true
require 'rails_helper'

RSpec.describe Group, type: :model do
  let!(:user) { create(:user) }
  let!(:group) { create(:group) }

  describe '幾つかのテーブルと関連を持っている' do
    context 'have a relation tro user class' do
      it { expect have_many(:albums) }
      it { expect have_many(:users) }
      it { expect have_many(:group_members) }
    end
  end

  describe '入力チェックをする' do
    context 'descriptionカラム' do
      it { is_expected.to validate_presence_of(:name) }
    end
  end

  describe '#save_with_group_member' do
    context 'group.saveが失敗した場合' do
      before do
        allow_any_instance_of(Group).to receive(:save).and_return(false)
      end

      it { expect(Group.new(name: 'test').save_with_group_member(user, GroupMember.role.owner)).to eq false }
      it 'group memberには登録されない' do
        Group.new(name: 'test').save_with_group_member(user, GroupMember.role.owner)
        group_members = GroupMember.where(user: user, role: GroupMember.role.owner)
        expect(group_members).to be_blank
      end
    end

    context 'group.saveが成功した場合' do
      it { expect(Group.new(name: 'test').save_with_group_member(user, GroupMember.role.owner)).to eq true }
      # it 'group memberには登録される' do
      #   Group.new(name: 'test').save_with_group_member(user, GroupMember.role.owner)
      #   group_member = GroupMember.where(user: user, role: GroupMember.role.owner).last
      #   expect(group_member.group_id).to eq Group.find_by(name: 'test').id
      # end
    end
  end
end
