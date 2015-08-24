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

  it 'allows you to remove an employee from a division' do
    Division.delete_all
    Employee.delete_all
    @employee = Employee.create({ name: 'Tim'})
    @division = Division.create({ name: 'Warehouse' })
    @employee.update({division_id: @division.id})
    visit '/divisions'
    expect(page).to have_content('Divisions Warehouse edit Tim delete Submit Home')
    click_link 'delete'
    expect(page).not_to have_content 'Tim'
  end
end
