namespace :search_testdata do
  desc '検索のテストデータセット'
  task exec: :environment do
    ENV['RAILS_ENV'] ||= "development"
    user  = User.all.first

    Rails.logger.info '===データ検索開始==='
    params = { keyword: 'テスト', user_id: user.id  }
    photos = Search::Photo.new(Photo, params).search

    photos.each do |photo|
      p photo
      Rails.logger.info photo.description
    end

    Rails.logger.info('データ検索完了')
  end
end
