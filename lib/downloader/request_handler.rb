require 'eventmachine'
require 'downloader/request_parser'
require 'downloader/downloads/http'
require 'downloader/file_utils'

module Downloader
  class RequestHandler < EM::Connection
    attr_accessor :cid, :message

    def post_init
      time = Time.now.to_s
      @cid = Digest::MD5.hexdigest(time)
      puts "(#{time}) --> client connected(cid: #{@cid})"
    end

    def receive_data(data)
      begin
        rp = Downloader::RequestParser.new(data)
        case rp.download_protocol
        when 'http'
          http_download = Downloader::Downloads::HTTP.new(rp.download_id).
                          get(rp.body)
          http_download.callback do
            FileUtils.generate_torrent(rp.download_id, rp.body)
            FileUtils.delete_progress_file(rp.download_id)
            send_data "wget exit code: #{http_download.exit_code}"
          end

          http_download.errback do
            begin
              File.delete(FileUtils.generate_download_path(rp.download_id, rp.body))
              FileUtils.delete_progress_file(rp.download_id)
            rescue Errno::ENOENT
            end
            send_data "wget exit code: #{http_download.exit_code}"
          end
        else
          send_data 'nope'
        end
      rescue Errors::InvalidRequestError
        puts "(#{Time.now.to_s}) --> Invalid request(by cid: #{@cid})"
        send_data "Invalid Request"
      end
    end

    def unbind
      puts "(#{Time.now.to_s}) --> client disconnected(cid: #{@cid})"
    end
  end
end