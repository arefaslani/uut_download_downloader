require "bundler/gem_tasks"
require 'fileutils'

namespace :db do
  task :prepare do
    FileUtils.mkdir File.join(File.dirname(__FILE__), 'db')
  end
end