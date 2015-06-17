lib = File.expand_path('../lib/', __FILE__)
$:.unshift lib unless $:.include?(lib)

require 'weather_forecasts/client/version'

Gem::Specification.new do |s|
  s.name = "weather-forecasts"
  s.version = WeatherForecasts::Client::VERSION
  s.platform = Gem::Platform::RUBY
  s.authors = ["Angelo Lakra"]
  s.email = ["angelo.lakra@gmail.com"]
  s.summary = "Client library for retrieving data from NOAA's weather forecast API"

  s.description = <<-EOT
   Utilizing the NDFD (National Weather Service Digital Forecast Database), weather forecasts are retrieved from NOAA's SOAP API and then translated into array/hash structures in Ruby.
  EOT

  s.homepage = "https://github.com/alakra/weather-forecasts"
  s.bindir = 'bin'
  s.licenses = ['MIT']

  s.extra_rdoc_files = ['README.md']

  s.executables << 'wf-console'

  s.add_runtime_dependency 'dwml', '~> 1.1.4'
  s.add_runtime_dependency 'savon', '~> 2.10.0'
  s.add_runtime_dependency 'httpi', '~>2.3.0'
  s.add_runtime_dependency 'nokogiri', '~> 1.6.1'
  s.add_runtime_dependency 'multi_json', '~> 1.11.0'
  s.add_runtime_dependency 'activesupport', '~> 4.2.2'
  s.add_runtime_dependency 'http_logger', '~> 0.5.1'

  s.post_install_message = "To start querying weather forecasts immediately, type `wf-console`."

  s.required_ruby_version = '>= 1.9.3'

  s.files = `git ls-files`.split("\n")
  s.test_files = `git ls-files -- spec/*`.split("\n")
  s.require_path = 'lib'
end
