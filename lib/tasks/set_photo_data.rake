namespace :setting_testdata do
  desc '検索のテストデータセット'
  task exec: :environment do
    ENV['RAILS_ENV'] ||= "development"
    user  = User.all.first
    album = Album.all.first
    Rails.logger.info '===データ作成開始==='
    (1..1000).each do
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
