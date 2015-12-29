# A sample Guardfile
# More info at https://github.com/guard/guard#readme

guard :rspec, cmd: 'bundle exec rspec', notification: true do
  watch('spec/.+_spec\.rb')
  watch('lib/(.+)\.rb')     { |m| "spec/lib/#{m[1]}_spec.rb" }

  # Rails example
  watch('app/(.+)\.rb')                           { |m| "test/#{m[1]}_spec.rb" }
  watch('ib/(.+)\.rb')                           { |m| "test/lib/#{m[1]}_spec.rb" }
  watch('app/controllers/(.+)_(controller)\.rb')  { |m| ["test/routing/#{m[1]}_routing_spec.rb", "spec/#{m[2]}s/#{m[1]}_#{m[2]}_spec.rb", "test/acceptance/#{m[1]}_spec.rb"] }
  watch('test/support/(.+)\.rb')                  { "test" }
  watch('test/test_helper.rb')                        { "test" }
  watch('config/routes.rb')                           { "test/routing" }
  watch('app/controllers/application_controller.rb')  { "test/controllers" }
  # Capybara request specs
  watch('app/views/(.+)/.*\.(erb|haml)')          { |m| "test/requests/#{m[1]}_spec.rb" }
end

guard :rubocop, notification: true  do
  watch('app/(.+)\.rb')
  watch('lib/(.+)\.rb')
  watch('test/(.+)\.rb')
end
