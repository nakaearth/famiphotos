namespace :ridgepole do
  desc 'ridgepole task'
  task 'db:migrate': :environment do
    ENV['RAILS_ENV'] ||= "development"
    exec "bundle exec ridgepole -E#{ENV['RAILS_ENV']} -c config/database.yml -f db/Schemafile --apply"
  end

  task dryrun: :environment do
    ENV['RAILS_ENV'] ||= "development"
    exec "bundle exec ridgepole -E#{ENV['RAILS_ENV']} -c config/database.yml -f db/Schemafile --apply --dry-run"
  end

  task 'rake:dump': :environment do
    ENV['RAILS_ENV'] ||= "development"
    exec "bundle exec ridgepole -E#{ENV['RAILS_ENV']} -c config/database.yml --export --split -o db/schemas/Schemafile"
  end
end
