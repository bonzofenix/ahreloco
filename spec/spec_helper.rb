require 'rubygems'
require 'spork'
#uncomment the following line to use spork with the debugger
require 'spork/ext/ruby-debug'

Spork.prefork do
  require "rails/application"
  # Loading more in this block will cause your tests to run faster. However,
  # if you change any configuration or code from libraries loaded here, you'll
  # need to restart spork for it take effect.
  # This file is copied to spec/ when you run 'rails generate rspec:install'
  ENV["RAILS_ENV"] ||= 'test'
  require File.expand_path("../../config/environment", __FILE__)
  require 'rspec/rails'
  require 'email_spec'
  require 'rspec/autorun'
  require 'factory_girl_rails'

  # Requires supporting ruby files with custom matchers and macros, etc,
  # in spec/support/ and its subdirectories.
  Dir[Rails.root.join("spec/support/**/*.rb")].each {|f| require f}

  OmniAuth.config.test_mode = true
  OmniAuth.config.mock_auth[:youtube] = OmniAuth::AuthHash.new( { 
    'provider' => 'youtube', 'uid' => '123545',
    'credentials'=> {'token' => 'this is the token'},
    'info'=> {'nickname' => 'bonzo',  'image' => 'http://image_url.com',
      'subscribers_count' => '3'},
    'extra'=>{ 'user_hash' => { 'yt$username' => {'$t'=> 'bonzofenix'}}}})


  #extra = Hashie::Mash.new('user_hash'=>'')
  #OmniAuth.config.mock_auth[:youtube].stub!(:extra).and_return(extra)  

  RSpec.configure do |config|
    config.include EmailSpec::Helpers
    config.include EmailSpec::Helpers
    config.include EmailSpec::Matchers
    config.include FactoryGirl::Syntax::Methods
    config.include Sessions

    # Remove this line if you're not using ActiveRecord or ActiveRecord fixtures
    config.fixture_path = "#{::Rails.root}/spec/fixtures"

    # If you're not using ActiveRecord, or you'd prefer not to run each of your
    # examples within a transaction, remove the following line or assign false
    # instead of true.
    config.use_transactional_fixtures = false

    # If true, the base class of anonymous controllers will be inferred
    # automatically. This will be the default behavior in future versions of
    # rspec-rails.
    config.infer_base_class_for_anonymous_controllers = false

    # Run specs in random order to surface order dependencies. If you find an
    # order dependency and want to debug it, you can fix the order by providing
    # the seed, which is printed after each run.
    #     --seed 1234
    config.order = "random"
    
    config.before(:suite) do
      DatabaseCleaner.strategy = :truncation
    end
    config.before(:each) do
      DatabaseCleaner.start
    end
    config.after(:each) do
      DatabaseCleaner.clean
    end
end

end

Spork.each_run do
  require 'factory_girl_rails'
  Dir["#{Rails.root}/app/models/**/*.rb"].each do |model|
    load model
  end
end





