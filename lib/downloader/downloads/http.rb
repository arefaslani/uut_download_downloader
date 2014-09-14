require 'eventmachine'
require 'uri'

module Downloader
  module Downloads
    class HTTP
      include EM::Deferrable
      attr_accessor :message, :download_id, :status, :downloaded_file_name
      
      def initialize(download_id)
        self.download_id = download_id
      end

      def get(uri, options={})
        file = File.open(File.join('logs', "#{self.download_id}.txt"))
        
        download_uri = ::URI.parse(uri)
        self.downloaded_file_name = "#{self.download_id}_#{download_uri.path.split('/').last}"
        download_path = ENV['UUT_DOWNLOAD_PATH'] || File.join(ENV['HOME'], 'leeching')

        f = IO.popen("wget #{uri} -O #{File.join(download_path, downloaded_file_name)} 2>&1", "r") do |pipe|
          pipe.each do |line|
            sleep 1
            if line.match(/\d%/)
              line.split().each do |part|
                p part if part.match(/\d%/)
              end
            end
          end
        end

        file.close

        return f.inspect
      end
    end
  end
end