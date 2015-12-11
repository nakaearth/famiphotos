Rake::Task['db:test:prepare'].clear

namespace :db do
  namespace :test do
    task :prepare do
      # rake testで実行されて困るので何もしない
    end
  end
end
