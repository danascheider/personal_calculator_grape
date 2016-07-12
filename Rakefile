unless ENV["RACK_ENV"] == "production"
  require "rambo"
  require "rspec/core/rake_task"

  Rambo::Rake::Task.new
  RSpec::Core::RakeTask.new

  task :default => [ :rambo, :spec ]
end