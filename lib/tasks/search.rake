namespace :search do
  desc '検索のテスト'
  task :test => :environment do
    params = { keyword: 'テスト' }

    photos = Search::Photo.new(params).search

    photos.each do |photo|
      p photo
    end
  end
end
