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
    Rails.logger.info '===データ作成開始==='
    album = Album.create(title: '誕生日会の写真')
    Rails.logger.info "photo data save!"
    Photo.create(
      description: "これは誕生日会の写真。",
      user: user,
      album: album,
      good_point: [*1..10].sample)
    Photo.create(
      description: "これはケーキの写真。",
      user: user,
      album: album,
      good_point: [*1..10].sample)

    album2 = Album.create(title: '運動会のアルバム')
    Rails.logger.info "photo data save!"
    Photo.create(
      description: "徒競走の写真です。",
      user: user,
      album: album2,
      good_point: [*1..10].sample)
    Photo.create(
      description: "器械体操の写真です。",
      user: user,
      album: album2,
      good_point: [*1..10].sample)

    album3 = Album.create(title: '旅行のアルバム')
    Rails.logger.info "photo data save!"
    Photo.create(
      description: "料理の写真です。",
      user: user,
      album: album3,
      good_point: [*1..10].sample)
    Photo.create(
      description: "温泉の写真です。",
      user: user,
      album: album3,
      good_point: [*1..10].sample)

    Rails.logger.info('データ作成完了')
  end
end
