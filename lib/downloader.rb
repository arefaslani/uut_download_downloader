require "downloader/version"
require 'eventmachine'
require 'downloader/request_handler'
require 'optparse'

module Downloader
  class Application

    def self.run
      get_options
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

        opts.on("-d", "--downloads-dir DIR", "Downloaded files go here.") do |dir|
          ENV['DOWNLOAD_PATH'] = dir
        end

        opts.on("-P", "--port PORT", "Set main process listener port.") do |port|
          ENV['PORT'] = port
        end

        opts.on("-p", "--port-web PORT", "Set web interface listener port.") do |port|
          ENV['PORT_WEB'] = port
        end

        opts.on("-t", "--tracker-address ADDRESS", "Set the torrent tracker address.") do |addresss|
          ENV['TRACKER_ADDRESS'] = addresss
        end

        opts.on("-T", "--tracker-port PORT", "Set the torrent tracker port.") do |port|
          ENV['TRACKER_PORT'] = port
        end
      end.parse!
    end
  end
end
