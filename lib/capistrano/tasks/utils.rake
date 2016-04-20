namespace :utils do
  task :ruby_version do
    on roles(:app) do
      execute "ruby -v"
    end
  end
end
