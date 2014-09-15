module Downloader
  module FileUtils
    # Gets the id and url of a download request and generates download path for it.
    def self.generate_download_path(id, url)
      download_uri = ::URI.parse(url)
      downloaded_file_name = "#{id}_#{download_uri.path.split('/').last}"
      download_path = ENV['UUT_DOWNLOAD_PATH'] || File.join(ENV['HOME'], 'leeching')
      return File.join(download_path, downloaded_file_name)
    end
  end
end