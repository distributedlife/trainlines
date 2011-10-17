# Add your own tasks in files placed in lib/tasks ending in .rake,
# for example lib/tasks/capistrano.rake, and they will automatically be available to Rake.

require File.expand_path('../config/application', __FILE__)
require 'rake'

Trainmap::Application.load_tasks

namespace :prod do
  desc "Take backup"
  task :backup do
    sh "heroku pgbackups:capture --expire --app trainlines"
  end
end

namespace :staging do
  desc "Copy latest prod backup to staging"
  task :copyfromprod do
    sh "heroku pgbackups:restore DATABASE `heroku pgbackups:url --app trainlines` --app trainlines-preprod --confirm trainlines-preprod"
  end
end

desc "Package assets for production"
task :assets do
  sh "bundle exec jammit --base-url http://trainlines.heroku.com"
end