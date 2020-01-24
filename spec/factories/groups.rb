# frozen_string_literal: true
FactoryBot.define do
  factory :group do
    name { 'myファミリー' }
    type { 'parent' }
  end

  trait :child do
    type { 'child' }
  end
end
