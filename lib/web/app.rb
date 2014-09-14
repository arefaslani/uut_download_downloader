require 'sinatra/base'
require 'sinatra/json'
require 'nokogiri'

class WebApp < Sinatra::Base
  get '/progress/:id.?:format?' do
    case params[:format]
    when 'json'
      content_type :json
      json id: params[:id]
    when 'xml'
      content_type :xml
      Nokogiri::XML::Builder.new do |xml|
        xml.progress do
          xml.id params[:id].to_s
        end
      end.to_xml.to_s
    end
  end
end
