ENV["ENV"] = "test"

# Uncomment this and comment out the coveralls code to generate local
# coverage reports
# require 'simplecov'
# SimpleCov.start

require 'weather-forecasts'

Bundler.require(:default, WeatherForecasts.env)

Time.zone = 'UTC'

require 'webmock/rspec'
require 'vcr'
require 'savon'

VCR.configure do |c|
  c.cassette_library_dir = 'spec/fixtures/vcr_cassettes'
  c.hook_into :webmock

  c.configure_rspec_metadata!
  c.ignore_localhost                        = true
  c.allow_http_connections_when_no_cassette = true
  c.default_cassette_options = {
    :allow_playback_repeats => true
  }
end

RSpec.configure do |config|
  config.run_all_when_everything_filtered = true
  config.filter_run :focus
  config.order = 'random'
end
