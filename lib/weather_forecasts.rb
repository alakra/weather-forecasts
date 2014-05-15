module WeatherForecasts
  module_function

  def env
    @@env ||= (ENV['ENV'] || :production)
  end

  def client(options = {})
    Client.new(options)
  end

  def root_path
    File.expand_path(File.join(File.dirname(__FILE__), "../"))
  end

  def vendor_path
    File.join(root_path, "vendor")
  end
end

require 'weather_forecasts/client'
require 'weather_forecasts/client/version'
