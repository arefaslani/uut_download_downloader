require 'eventmachine'
require 'uri'
require 'downloader/file_utils'

module Downloader
  module Downloads
    class HTTP
      include EM::Deferrable
      attr_accessor :message, :download_id, :status, :downloaded_file_name
      
      def initialize(download_id)
        self.download_id = download_id
      end

      def get(uri, options={})
        process = IO.popen("wget #{uri} -O #{FileUtils.generate_download_path(self.download_id, uri)} 2>&1", "r")
        process.each do |line|
          sleep 1
          if line.match(/\d%/)
            line.split().each do |part|
              if part.match(/\d%/)
                puts part
                File.open(File.expand_path(File.join('logs', "#{self.download_id}.txt")), 'w+') do |file|
                  file.write(part)
                end
              end
            end
          end
        end

        _, status = Process::waitpid2 process.pid
        process.close

        exit_code = status.to_s.split().last.strip.to_i

        case exit_code
        when 0
          set_deferred_status :succeeded
          return "Wget exit code: 0"
        else
          set_deferred_status :failed
          return "Wget exit code: #{exit_code}"
        end
      end
    end
  end
end