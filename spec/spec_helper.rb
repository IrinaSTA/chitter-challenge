ENV['RACK_ENV'] = 'test'

require File.join(File.dirname(__FILE__), '..', 'app.rb')

require 'capybara'
require 'capybara/rspec'
require 'rake'
require 'rspec'
require 'simplecov'
require 'simplecov-console'

Rake.application.load_rakefile

Capybara.app = ChitterApp

SimpleCov.formatter = SimpleCov::Formatter::MultiFormatter.new([
  SimpleCov::Formatter::Console,
  # Want a nice code coverage website? Uncomment this next line!
  SimpleCov::Formatter::HTMLFormatter
])
SimpleCov.start

RSpec.configure do |config|

  # Sets up necessary databases if they don't exist
  config.before(:suite) do
    Rake::Task['setup'].execute
  end

  # Truncates test database tables before each test
  config.before(:each) do
    Rake::Task['test_database_setup'].execute
  end

  config.after(:suite) do
    puts
    puts "\e[33mHave you considered running rubocop? It will help you improve your code!\e[0m"
    puts "\e[33mTry it now! Just run: rubocop\e[0m"
  end
end
