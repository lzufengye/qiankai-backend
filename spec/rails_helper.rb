
ENV['RAILS_ENV'] ||= 'test'
require 'spec_helper'
require File.expand_path('../../config/environment', __FILE__)
require 'rspec/rails'
require 'devise'
require 'byebug'
require 'faker'

Dir[Rails.root.join("spec/support/**/*.rb")].each { |f| require f }

ActiveRecord::Migration.maintain_test_schema!

Dir.mkdir('tmp') unless File.directory?('tmp')

RSpec.configure do |config|
  config.render_views
  config.fixture_path = "#{::Rails.root}/spec/fixtures"
  config.use_transactional_fixtures = false
  config.infer_spec_type_from_file_location!

  config.include FactoryGirl::Syntax::Methods
  config.include Devise::TestHelpers, type: :controller
  config.include Warden::Test::Helpers

  config.before :suite do
    DatabaseRewinder.clean_all
  end

  config.after do
    DatabaseRewinder.clean
  end
end

def json_fixture(name)
  JSON.parse(File.read(File.join(File.dirname(__FILE__), 'fixtures', "#{name}.json")))
end

def register_as_consumer
  consumer = FactoryGirl.create(:consumer)
  login_as_consumer consumer
end

def login_as_consumer consumer
  sign_in consumer
  sign_out consumer
  consumer.authentication_token
end
