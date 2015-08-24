require 'sinatra/activerecord'
require 'sinatra'
require './lib/division'
require './lib/employee'
require 'pg'
require 'sinatra/reloader'
require 'pry'

get '/'  do
	erb(:index)
end



get '/divisions' do
	# @divisions = Division.all
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
	#binding.pry
	if params['employee'] != 'employees'
	  @employee = Employee.find(params['employee'])
	  @employee.update({ division_id: params['id'] })
	end
	@division = Division.find(params['id'])

	@division.update({ name: params['name'] }) if params['name'] != ''
	redirect '/divisions'
end

get '/employees' do
	erb :employees
end

post '/employees' do
	@employee = Employee.create({name: params['name']})
	erb :employees
end

get '/employees/:id/edit' do
	@employee = Employee.find(params['id'].to_i)
	erb :employee_edit
end

patch '/employees/:id' do
	@employee = Employee.find(params['id'].to_i)
	@employee.update({name: params['name']})
	erb :employee_edit
end

delete '/employees/:id' do
	@employee = Employee.find(params['id'].to_i)
	@employee.destroy
	redirect '/employees'
end

get '/remove_employee/:id' do
	@employee = Employee.find(params['id'].to_i)
	@employee.update({ division_id: 0 })
	redirect '/divisions'
end
