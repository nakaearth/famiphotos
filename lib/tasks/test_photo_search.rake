# frozen_string_literal: true
namespace :search_testdata do
  desc '検索のテスト'
  task exec: :environment do
    ENV['RAILS_ENV'] ||= "development"
    user = User.all.last

    Rails.logger.info '===データ検索開始==='
    params  = { keyword: 'テスト', user_id: user.id }
    service = Search::Photo.new(Photo, params)
    service.search
    photos  = service.hits_count

    photos.each_with_hit do |photo, hit|
      puts "#{photo.description}: #{hit._score}"
    end

    aggre_photos = service.aggregations
    puts "=====アグリゲーション====="
    p aggre_photos
    puts "=============="

    Rails.logger.info('データ検索完了')
  end
end
