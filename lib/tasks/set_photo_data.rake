namespace :setting_testdata do
  desc '検索のテストデータセット'
  task :exec do
    ENV['RAILS_ENV'] ||= "development"
    user  = User.all.first
    album = Album.all.first
    [1..1000].each do
      Photo.new(
        description: "これはテスト。#{[*1..100].sample}犬の画像です。",
        user: user,
        album: album,
        good_point: [*1..10].sample
      ).save!
    end
  end
end
