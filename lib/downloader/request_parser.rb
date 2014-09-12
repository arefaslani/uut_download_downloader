require 'downloader/errors/invalid_request_error'

module Downloader
  # A request type is like this:
  # => DOWNLOAD_ID: 1231231
  # => DOWNLOAD_PROTOCOL: HTTP
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

    def body
      self.data.split("\n\n")[1].strip
    end

    private

    # Gets a raw request as defined above and make a hash from it
    # and returns something like:
    # {download_id: '12313112', download_protocol: 'http'}
    def prepare_headers
      raw_headers = self.data.split("\n\n")[0]
      raw_headers.split("\n").each do |header|
        key, value = header.split(":")
        self.headers[key.strip.downcase] = value.strip.downcase
      end
    end
  end
end