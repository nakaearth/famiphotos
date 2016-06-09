namespace :ridgepole do
  desc 'ridgepole apply task'
  task :apply => :environment do
    ENV['RAILS_ENV'] ||= "development"
    sh "bundle exec ridgepole -E#{ENV['RAILS_ENV']} -c config/database.yml -f db/schemas/Schemafile --apply"
    Rake::Task['db:schema:dump'].invoke
  end

  desc 'ridgepole schema file export'
  task :export => :environment do
    ENV['RAILS_ENV'] ||= "development"
    sh "bundle exec ridgepole -E#{ENV['RAILS_ENV']} -c config/database.yml --export --split -o db/schemas/Schemafile"
  end
end
