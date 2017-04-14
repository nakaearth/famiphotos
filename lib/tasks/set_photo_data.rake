# frozen_string_literal: true
namespace :setting_testdata do
  desc '検索のテストデータセット'
  task exec: :environment do
    ENV['RAILS_ENV'] ||= "development"
    auth = { uid: '11111222333', provider: 'twitter',
             info: {
               name: 'hoge', email: 'test@gmail.com',
               nickname: 'test nick name', image: 'http://test.co.jp/test.jpeg'
             },
             credentials: { token: 'hogheog1211414', secret: 'testsecret125253' } }
    user  = Users::Registration.new.regist(auth)
    group = Group.create(name: 'test group')
    album = Album.create(group: group, title: 'test album')
    Rails.logger.info '===データ作成開始==='
    1000.times do
      Rails.logger.info "photo data save!"
      Photo.new(
        description: "これはテスト。#{[*1..100].sample}犬の画像です。",
        user: user,
        album: album,
        good_point: [*1..10].sample
      ).save!
    end

    Rails.logger.info('データ作成完了')
  end
end
