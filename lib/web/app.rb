require 'sinatra'

get '/progress/:id' do
  "Download id: #{params[:id]}"
end