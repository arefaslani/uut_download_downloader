require 'eventmachine'
require 'uri'
require 'downloader/file_utils'

module Downloader
  module Downloads
    class HTTP
      include EM::Deferrable
      attr_accessor :message, :download_id, :status, :downloaded_file_name, :exit_code
      
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
                FileUtils.write_log(self.download_id, part, mode: 'w')
              end
            end
          end
        end

        _, status = Process::waitpid2 process.pid
        process.close

        self.exit_code = status.to_s.split().last.strip.to_i

        case self.exit_code
        when 0
          set_deferred_status :succeeded
        else
          set_deferred_status :failed
        end

        return self
      end
    end
  end
end