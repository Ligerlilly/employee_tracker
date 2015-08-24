ENV['RACK_ENV'] = 'test'

require 'rspec'
require 'pg'
require 'sinatra/activerecord'
require 'employee'
require 'division'

RSpec.configure do |config|
  config.after(:each) do
    Employee.all.each do |task|
      task.destroy
    end
  end
end
