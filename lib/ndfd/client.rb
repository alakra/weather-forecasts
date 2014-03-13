require 'nokogiri'
require 'savon'
require 'http_logger'

require 'ndfd/client/error'
require 'ndfd/client/query'

# Original web service description: http://graphical.weather.gov/xml/
module NDFD
  class Client
    DEFAULT_WSDL = "http://graphical.weather.gov/xml/DWMLgen/wsdl/ndfdXML.wsdl"

    def initialize(options = {})
      @options = options

      if options[:wsdl].blank?
        @options.merge!(:wsdl => NDFD::Client::DEFAULT_WSDL)
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
      NDFD::Client::SelectQuery.new(soap_client, options)
    end

    def select_by_days
      NDFD::Client::SelectByDaysQuery.new(soap_client)
    end

    def select_coordinates_by_zip
      NDFD::Client::SelectCoordinatesByZipQuery.new(soap_client)
    end

    def select_coordinates_by_cities
      NDFD::Client::SelectCoordinatesByCitiesQuery.new(soap_client)
    end

    def select_square_coordinates
      NDFD::Client::SelectSquareCoordinatesQuery.new(soap_client)
    end

    def select_gridpoint_coordinates
      NDFD::Client::SelectGridpointCoordinatesQuery.new(soap_client)
    end

    def select_linepoint_coordinates
      NDFD::Client::SelectLinepointCoordinatesQuery.new(soap_client)
    end

    def select_corner_coordinates
      NDFD::Client::SelectCornerCoordinatesQuery.new(soap_client)
    end
  end
end
