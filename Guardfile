# A sample Guardfile
# More info at https://github.com/guard/guard#readme

guard :rspec, cmd: 'bundle exec rspec', notification: true do
  watch('spec/.+_spec\.rb')
  watch('lib/(.+)\.rb')     { |m| "spec/lib/#{m[1]}_spec.rb" }

  # Rails example
  watch('app/(.+)\.rb')                           { |m| "spec/#{m[1]}_spec.rb" }
  watch('ib/(.+)\.rb')                           { |m| "spec/lib/#{m[1]}_spec.rb" }
  watch('app/controllers/(.+)_(controller)\.rb')  { |m| ["spec/routing/#{m[1]}_routing_spec.rb", "spec/#{m[2]}s/#{m[1]}_#{m[2]}_spec.rb", "spec/acceptance/#{m[1]}_spec.rb"] }
  watch('spec/support/(.+)\.rb')                  { "spec" }
  watch('spec/spec_helper.rb')                        { "spec" }
  watch('config/routes.rb')                           { "spec/routing" }
  watch('app/controllers/application_controller.rb')  { "spec/controllers" }
  # Capybara request specs
  watch('app/views/(.+)/.*\.(erb|haml)')          { |m| "spec/requests/#{m[1]}_spec.rb" }
end

guard :rubocop, notification: true  do
  watch('app/(.+)\.rb')
  watch('lib/(.+)\.rb')
  watch('spec/(.+)\.rb')
end
