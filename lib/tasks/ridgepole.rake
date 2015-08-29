namespace :ridgepole do
  desc 'ridgepole task'
  task 'apply' => :environment do
    ENV['RAILS_ENV'] ||= "development"
    sh "bundle exec ridgepole -E#{ENV['RAILS_ENV']} -c config/database.yml --apply"
  end

  task 'dry-run' => :environment do
    ENV['RAILS_ENV'] ||= "development"
    sh "bundle exec ridgepole -E#{ENV['RAILS_ENV']} -c config/database.yml --apply --dry-run"
  end

  task 'dump' => :environment do
    ENV['RAILS_ENV'] ||= "development"
    sh "bundle exec ridgepole -E#{ENV['RAILS_ENV']} -c config/database.yml --export --split -o Schemafile"
  end
end
