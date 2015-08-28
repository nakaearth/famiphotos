namespace :ridgepole do
  desc 'ridgepole task'
  task 'apply' => :environment do
    ENV['RAILS_ENV'] ||= "development"
    sh "bin/ridgepole -E#{ENV['RAILS_ENV']} -c config/database.yml --apply"
  end

  task 'dry-run' => :environment do
    ENV['RAILS_ENV'] ||= "development"
    sh "bin/ridgepole -E#{ENV['RAILS_ENV']} -c config/database.yml --apply --dry-run"
  end
end
