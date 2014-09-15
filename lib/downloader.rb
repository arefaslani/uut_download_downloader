require "downloader/version"
require 'eventmachine'
require 'downloader/request_handler'

module Downloader
  class Application
    def self.run
      puts "Server Started..."
      begin
        EM.run do
          EM.start_server('0.0.0.0', ENV['PORT'].to_i, Downloader::RequestHandler)
        end
      rescue Interrupt
        puts "Server Stopped."
      end
    end
  end
end
