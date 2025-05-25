require 'sinatra/base'
require 'symbolic_differentiator'

class DiffApp < Sinatra::Base
  set :public_folder, File.dirname(__FILE__) + '/public'
  
  get '/' do
    erb :index
  end

  post '/differentiate' do
    @expression = params[:expression].gsub(/\s+/, '')
    @variable = params[:variable]
    
    begin
      @result = SymbolicDifferentiator.differentiate(@expression, @variable)
    rescue => e
      @error = "Ошибка: #{e.message}"
    end
    
    erb :index
  end
end