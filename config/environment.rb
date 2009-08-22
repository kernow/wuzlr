# Be sure to restart your server when you modify this file

# Specifies gem version of Rails to use when vendor/rails is not present
RAILS_GEM_VERSION = '2.3.3' unless defined? RAILS_GEM_VERSION

# Bootstrap the Rails environment, frameworks, and default configuration
require File.join(File.dirname(__FILE__), 'boot')

Rails::Initializer.run do |config|
  config.time_zone = 'UTC'
  
  config.gem "thoughtbot-clearance",
    :lib     => 'clearance',
    :source  => 'http://gems.github.com',
    :version => '0.7.0'

  config.gem "justinfrench-formtastic", 
    :lib     => 'formtastic', 
    :source  => 'http://gems.github.com'
    
  config.gem "mbleigh-seed-fu",
    :lib     => 'seed-fu',
    :source  => 'http://gems.github.com'
  
  config.gem 'pluginaweek-state_machine',
    :lib     => 'state_machine',
    :version => '>= 0.7.6',
    :source  => "http://gems.github.com"

end

DO_NOT_REPLY = "donotreply@wuzlr.com"