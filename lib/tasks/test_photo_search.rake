# frozen_string_literal: true
namespace :search_testdata do
  desc '検索のテスト'
  task exec: :environment do
    ENV['RAILS_ENV'] ||= "development"
    user = User.all.first

    Rails.logger.info '===データ検索開始==='
    params = { keyword: 'テスト', user_id: user.id }
    photos = Search::Photo.new(Photo, params).search_with_hits_data

    photos.each_with_hit do |photo, hit|
      puts "#{photo.description}: #{hit._score}"
    end

    aggre_photos = Search::Photo.new(Photo, params).search_with_aggregations
    p aggre_photos

    Rails.logger.info('データ検索完了')
  end
end
