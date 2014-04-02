module WeatherForecasts
  class Client
    class SelectLinepointCoordinatesQuery < Query
      include QueryUtilities

      property :start_coordinate, :type => Hash, :required => true, :required_keys => [:latitude, :longitude]
      property :stop_coordinate,  :type => Hash, :required => true, :required_keys => [:latitude, :longitude]

      def execute
        validate

        response = soap_client.call(:lat_lon_list_line, :message => build_message)
        document = parse_xml(response)
        transform_coordinate_list(document)
      end

      protected

      def build_message
        {
          :endPoint1Lat => conditions[:start_coordinate][:latitude],
          :endPoint1Lon => conditions[:start_coordinate][:longitude],
          :endPoint2Lat => conditions[:stop_coordinate][:latitude],
          :endPoint2Lon => conditions[:stop_coordinate][:longitude]
        }
      end

      def parse_xml(response)
        Nokogiri::XML(response.body[:lat_lon_list_line_response][:list_lat_lon_out])
      end
    end
  end
end
