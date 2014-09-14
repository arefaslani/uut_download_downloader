require 'sinatra/base'
require 'sinatra/json'

class WebApp < Sinatra::Base
  get '/progress/:id/:format' do
    case params[:format]
    when 'json'
      json id: params[:id]
    end
  end
end
