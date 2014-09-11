require 'eventmachine'
require_relative 'request_parser'
# require_relative 'http_download'
require 'em-http-request'

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
          http_download = EM::HttpRequest.new(rp.body).get
          send_data http_download.response
          # send_data http_download.message.to_s
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