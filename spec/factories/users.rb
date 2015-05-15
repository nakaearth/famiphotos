FactoryGirl.define do
  factory :user do
    name "テスト太郎"
    email "test@gmail.com"
    decrypted_password "これはテストです"
    provider "test_provider"
    access_token "12345aabc"
    secret_token "09876zxy"
  end
end
