require 'sinatra'

set :port, 8080

get '/progress/:id' do
  "Download id: #{params[:id]}"
end