require 'spec_helper'
require 'capybara/rspec'
require './app.rb'

Capybara.app = Sinatra::Application
set(:show_exceptions, false)

describe 'employee tracker path', {type: :feature} do
  it 'allows you to create divisions' do
    visit('/')
    click_link 'Divisions'
    fill_in 'name', with: 'IT'
    click_button 'Submit'
    expect(page).to have_content('IT')
  end

  it 'allows you to delete divisions' do
    Division.delete_all
    @division = Division.create({ name: 'Tea' })
    visit "/divisions/#{@division.id}/edit"
    expect(page).to have_content 'Tea'
    click_button 'Delete'
    expect(page).not_to have_content "Tea"
  end

  it 'allows you to update divisions' do
    @division = Division.create({ name: 'Construstion'})
    visit "/divisions/#{@division.id}/edit"
    fill_in 'name', with: 'Not construction'
    click_button 'Submit'
    expect(page).to have_content 'Not construction'
  end

  it 'allows you to add an employee' do
    visit '/'
    click_link 'Employees'
    fill_in 'name', with: 'Todd'
    click_button 'Submit'
    expect(page).to have_content 'Todd'
  end

  it 'allows you to update an employee' do
  @employee = Employee.create(name: 'Winston')
  visit '/employees'
  click_link 'edit'
  fill_in 'name', with: 'Bill'
  click_button 'Submit'
  expect(page).to have_content 'Bill'
  end

  it 'allows you to delete an employee' do
    @employee = Employee.create({ name: 'Tim'})
    visit '/employees'
    click_link 'edit'
    click_button 'Delete'
    expect(page).not_to have_content('Tim')
  end

  it 'allows you to remove an employee from a project' do
    Project.delete_all
    Employee.delete_all
    @project = Project.create(name: 'Warehouse')
    @employee = Employee.create({ name: 'Tim'})
    @employee.update({ project_id: @project.id })
    visit '/projects'
    expect(page).to have_content('Projects Warehouse edit Tim delete Submit Home')
    click_link 'delete'
    expect(page).not_to have_content 'Tim'
  end

  it 'allows you to add a project' do
    visit '/'
    click_link 'Projects'
    fill_in 'name', with: 'Black Mesa'
    click_button('Submit')
    expect(page).to have_content 'Black Mesa'
  end

  it 'allows you to delete a project' do
    Project.delete_all
    @project = Project.create(name: 'Manhattan')
    visit '/projects'
    click_link 'edit'
    click_button 'Delete'
    expect(page).not_to have_content('Manhattan')
  end
end
