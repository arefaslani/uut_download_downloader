module Downloader
  module FileUtils
    # Gets the id and url of a download request and generates download path for it.
    def self.generate_download_path(id, url)
      download_uri = ::URI.parse(url)
      downloaded_file_name = "#{id}_#{download_uri.path.split('/').last}"
      download_path = ENV['DOWNLOAD_PATH']
      return File.join(download_path, downloaded_file_name)
    end

    def self.write_log(id, message, options={})
      options[:mode] ||= 'a'
      File.open(File.expand_path(File.join('logs', "#{id}.txt")), options[:mode]) do |file|
        file.write(message)
      end
    end

    def self.generate_torrent(id, url)
      system("mktorrent -o #{self.generate_download_path(id, url)}.torrent \\
              -a udp://#{ENV['TRACKER_ADDRESS']}:#{ENV['TRACKER_PORT']}/announce \\
              -a http://#{ENV['TRACKER_ADDRESS']}:#{ENV['TRACKER_PORT']}/announce \\
              #{self.generate_download_path(id, url)}")
    end
  end
end