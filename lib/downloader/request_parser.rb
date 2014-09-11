require_relative 'errors'

module Downloader
  # A request type is like this:
  # => HTTP|12314124|UUTDOWNLOAD/0.1
  # => \n\n
  # => HTTP://www.test.com/file.iso
  class RequestParser
    attr_reader :data

    def initialize(request_data)
      @data = request_data
      validate_request
    end

    def download_protocol
      headers[0].downcase
    end

    def download_id
      headers[1]
    end

    def protocol_version
      headers[2].split("\/")[1]
    end

    def body
      @data.split("\n\n")[1]
    end

    private

    def headers
      raw_headers = @data.split("\n\n")[0]
      raw_headers.split("|")
    end

    def validate_request
      raise Errors::InvalidRequestError unless headers[0].match(/^(http|https|ftp|ftps|bittorrent|magnet)$/i)
      raise Errors::InvalidRequestError unless headers[1].match(/^\d+$/)
      raise Errors::InvalidRequestError unless headers[2].match(/^UUTDOWNLOAD\/\d\.\d$/)
    end
  end
end