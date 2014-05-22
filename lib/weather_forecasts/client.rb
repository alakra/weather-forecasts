require 'nokogiri'
require 'savon'
require 'http_logger'

require 'weather_forecasts/client/error'
require 'weather_forecasts/client/query'

# Original web service description: http://graphical.weather.gov/xml/
module WeatherForecasts
  class Client
    DEFAULT_WSDL = "http://graphical.weather.gov/xml/DWMLgen/wsdl/ndfdXML.wsdl"

    def initialize(options = {})
      @options = options

      if options[:wsdl].blank?
        @options.merge!(:wsdl => DEFAULT_WSDL)
      end

      if options[:logger].present?
        HttpLogger.logger = options[:logger]
      end
    end

    def soap_client
      @soap_client ||= Savon.client(@options)
    end

    #
    # Query Methods
    ############################################################################

    def select(*options)
      SelectQuery.new(soap_client, options)
    end

    def select_hourly
      SelectHourlyQuery.new(nil)
    end

    def select_by_days
      SelectByDaysQuery.new(soap_client)
    end

    def select_coordinates_by_zip
      SelectCoordinatesByZipQuery.new(soap_client)
    end

    def select_coordinates_by_cities
      SelectCoordinatesByCitiesQuery.new(soap_client)
    end

    def select_square_coordinates
      SelectSquareCoordinatesQuery.new(soap_client)
    end

    def select_gridpoint_coordinates
      SelectGridpointCoordinatesQuery.new(soap_client)
    end

    def select_linepoint_coordinates
      SelectLinepointCoordinatesQuery.new(soap_client)
    end

    def select_corner_coordinates
      SelectCornerCoordinatesQuery.new(soap_client)
    end
  end
end
