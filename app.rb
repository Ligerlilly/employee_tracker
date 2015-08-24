require 'sinatra/activerecord'
require 'sinatra'
require './lib/division'
require './lib/employee'
require 'pg'
require 'sinatra/reloader'

get '/'  do
	erb(:index)
end



get '/divisions' do
	@divisions = Division.all
	erb :divisions
end

post '/divisions' do
  @division = Division.create({ name: params['name'] })
	erb :divisions
end

get '/divisions/:id/edit' do
  @division = Division.find(params['id'].to_i)
	erb :edit
end

delete '/divisions/:id' do
	@division = Division.find(params['id'].to_i)
	@division.destroy
	redirect '/divisions'
end

patch '/divisions/:id' do
	@division = Division.find(params['id'])
	@division.update({name: params['name']})
	erb :edit
end
