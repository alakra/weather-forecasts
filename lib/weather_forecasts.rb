# The weather forecasts library retrieves weather forecast data from
# NOAA.  The dataset that is specifically being retrieved is from the
# NDFD ( National Digital Forecast Database )/
#
# Author::    Angelo Lakra  (mailto:angelo.lakra@gmail.com)
# License::   MIT License

module WeatherForecasts
  module_function

  # Returns the currently set environment (`:test, :development or
  # :production`)
  #
  # This can be set from the shell environment using the `ENV`
  # variable.

  def env
    @@env ||= (ENV['ENV'].to_sym || :production)
  end

  # Returns a new instance of WeatherForecasts::Client

  def client(options = {})
    Client.new(options)
  end

  # Returns the root path from the install path of the project

  def root_path
    File.expand_path(File.join(File.dirname(__FILE__), "../"))
  end

  # Returns the vendor path from the install path of the project

  def vendor_path
    File.join(root_path, "vendor")
  end
end

require 'weather_forecasts/client'
require 'weather_forecasts/client/version'
