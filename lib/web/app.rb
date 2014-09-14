require 'sinatra/base'

class WebApp < Sinatra::Base
  get '/progress/:id' do
    "Download id: #{params[:id]}"
  end
end
