namespace :ridgepole do
  task 'db:migrate' => :environment do
    ENV['RAILS_ENV'] ||= "development"
    sh "bin/ridgepole -E#{ENV['RAILS_ENV']} -c config/database.yml --apply"
  end

  task 'db:migrate' => :environment do
    ENV['RAILS_ENV'] ||= "development"
    sh "bin/ridgepole -E#{ENV['RAILS_ENV']} -c config/database.yml --apply --dry-run"
  end
end
