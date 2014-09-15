module Downloader
  module FileUtils
    # Gets the id and url of a download request and generates download path for it.
    def self.generate_download_path(id, url)
      download_uri = ::URI.parse(url)
      downloaded_file_name = "#{id}_#{download_uri.path.split('/').last}"
      download_path = ENV['UUT_DOWNLOAD_PATH'] || File.join(ENV['HOME'], 'leeching')
      return File.join(download_path, downloaded_file_name)
    end

    def self.write_log(id, message, options={})
      options[:mode] ||= 'a'
      File.open(File.expand_path(File.join('logs', "#{id}.txt")), options[:mode]) do |file|
        file.write(message)
      end
    end
  end
end