require "downloader/version"
require 'eventmachine'
require 'downloader/request_handler'
require 'downloader/web/app'
require 'optparse'

module Downloader
  class Application

    def self.run
      get_options

      Process.fork do
        Downloader::Web::App.run!
      end

      puts "Server Started..."
      begin
        EM.run do
          EM.start_server('0.0.0.0', ENV['PORT'].to_i, Downloader::RequestHandler)
        end
      rescue Interrupt
        puts "Server Stopped."
      end
    end

    def self.get_options

      OptionParser.new do |opts|
        opts.banner = "Usage: downloader [options]"

        ENV['DOWNLOAD_PATH'] = File.join(ENV['HOME'], 'leeching')
        opts.on("-d", "--downloads-dir DIR", "Downloaded files go here(Default: ~/leeching).") do |dir|
          ENV['DOWNLOAD_PATH'] = dir
        end

        ENV['PORT'] = "9000"
        opts.on("-P", "--port PORT", "Set main process listener port(Default: 9000).") do |port|
          ENV['PORT'] = port
        end

        ENV['TRACKER_ADDRESS'] = "0.0.0.0"
        opts.on("-t", "--tracker-address ADDRESS", "Set the torrent tracker address(Default: 0.0.0.0).") do |addresss|
          ENV['TRACKER_ADDRESS'] = addresss
        end

        ENV['TRACKER_PORT'] = "6969"
        opts.on("-p", "--tracker-port PORT", "Set the torrent tracker port(Default: 6969).") do |port|
          ENV['TRACKER_PORT'] = port
        end
      end.parse!
    end
  end
end
