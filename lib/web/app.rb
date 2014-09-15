require 'sinatra/base'
require 'sinatra/json'
require 'nokogiri'

class WebApp < Sinatra::Base
  get '/progress/:id.?:format?' do |id, format|
    progress = begin
      File.read(File.expand_path(File.join('logs/', "#{id}.txt")))
    rescue
      "-1"
    end

    case format
    when 'json'
      content_type :json
      json id: id, progress: progress
    when 'xml'
      content_type :xml
      Nokogiri::XML::Builder.new do |xml|
        xml.file do
          xml.id id
          xml.progress progress
        end
      end.to_xml.to_s
    end
  end
end
