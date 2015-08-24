require 'sinatra/activerecord'
require 'sinatra'
require './lib/project'
require './lib/division'
require './lib/employee'
require 'pg'
require 'sinatra/reloader'
require 'pry'

get '/'  do
	erb(:index)
end

get '/projects' do

	erb :projects
end

post '/projects' do
	@project = Project.create({ name: params['name'] })
	erb :projects
end

get '/projects/:id/edit' do
	@project = Project.find(params['id'].to_i)
	erb :project_edit
end

patch '/projects/:id' do
	if params['employee'] != 'employees'
		@employee = Employee.find(params['employee'])
		@employee.update({ project_id: params['id'] })
	end
	@project = Project.find(params['id'])
	@project.update({ name: params['name'] }) if params['name'] != ''
	redirect '/projects'
end

delete '/projects/:id' do
	@project = Project.find(params['id'].to_i)
	@project.destroy
	redirect :projects
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
	erb :division_edit
end

delete '/divisions/:id' do
	@division = Division.find(params['id'].to_i)
	@division.destroy
	redirect '/divisions'
end

patch '/divisions/:id' do
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
