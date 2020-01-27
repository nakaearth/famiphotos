# frozen_string_literal: true
FactoryBot.define do
  factory :group do
    name { 'myファミリー' }
    dir_id { 0 }
  end

  trait :child do
    dir_id { 1 }
  end
end
