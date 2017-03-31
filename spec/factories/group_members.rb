# frozen_string_literal: true
FactoryGirl.define do
  factory :group_member do
    role 'owner'

    trait :member do
      role 'member'
    end
  end
end
