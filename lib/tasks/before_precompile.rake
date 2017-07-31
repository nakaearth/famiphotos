task :build_frontend do
  cd "client" do
    sh "npm install"
    sh "npm  build"
  end
end

Rake::Task["assets:precompile"].enhance(%i(build_frontend)) if Rails.env.production?
