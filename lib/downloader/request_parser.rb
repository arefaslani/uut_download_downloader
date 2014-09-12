require_relative 'errors'

module Downloader
  # A request type is like this:
  # => HTTP|12314124|UUTDOWNLOAD/0.1
  # => \n\n
  # => HTTP://www.test.com/file.iso
  class RequestParser
    attr_accessor :data, :headers

    def initialize(request_data)
      self.data = request_data
      self.headers = {}
      prepare_headers
      # validate_request
    end

    def download_protocol
      self.headers['download_protocol']
    end

    def download_id
      self.headers['download_id']
    end

    # def protocol_version
    #   headers[2].split("\/")[1]
    # end

    def body
      self.data.split("\n\n")[1].strip
    end

    private

    def prepare_headers
      raw_headers = self.data.split("\n\n")[0]
      raw_headers.split("\n").each do |header|
        key, value = header.split(":")
        self.headers[key.strip.downcase] = value.strip.downcase
      end
    end

    # def headers
    #   raw_headers = @data.split("\n\n")[0]
    #   raw_headers.split("|")
    # end

    # def validate_request
    #   raise Errors::InvalidRequestError unless headers[0].match(/^(http|https|ftp|ftps|bittorrent|magnet)$/i)
    #   raise Errors::InvalidRequestError unless headers[1].match(/^\d+$/)
    #   raise Errors::InvalidRequestError unless headers[2].match(/^UUTDOWNLOAD\/\d\.\d$/)
    # end
  end
end