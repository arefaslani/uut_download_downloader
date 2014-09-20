require "bundler/gem_tasks"
require 'fileutils'
require "sequel"

namespace :db do
  desc "Run migrations"
  task :migrate, [:version] do |t, args|
    FileUtils.mkdir_p File.expand_path(File.join(File.dirname(__FILE__), 'db'))
    FileUtils.mkdir_p File.expand_path(File.join(File.dirname(__FILE__), 'db/migrations'))
    
    Sequel.extension :migration
    db = Sequel.connect(File.expand_path(File.join(File.dirname(__FILE__), 'db/production.db')))
    if args[:version]
      puts "Migrating to version #{args[:version]}"
      Sequel::Migrator.run(db, File.expand_path(File.join(File.dirname(__FILE__), "db/migrations")),
                           target: args[:version].to_i)
    else
      puts "Migrating to latest"
      Sequel::Migrator.run(db, File.expand_path(File.join(File.dirname(__FILE__), "db/migrations")))
    end
  end
end