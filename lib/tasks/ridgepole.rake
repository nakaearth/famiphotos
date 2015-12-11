task 'db:migrate' => :environment do
  ENV['RAILS_ENV'] ||= "development"
  sh "bundle exec ridgepole -E#{ENV['RAILS_ENV']} -c config/database.yml -f db/Schemafile --apply"
  Rake::Task['db:schema:dump'].invoke
end

task 'db:dump' => :environment do
  ENV['RAILS_ENV'] ||= "development"
  sh "bundle exec ridgepole -E#{ENV['RAILS_ENV']} -c config/database.yml --export -o db/Schemafile"
end
