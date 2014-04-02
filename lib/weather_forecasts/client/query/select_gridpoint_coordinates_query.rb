module WeatherForecasts
  class Client
    class SelectGridpointCoordinatesQuery < Query
      include QueryUtilities

      property :lower_left_coordinate,  :type => Hash, :required => true, :required_keys => [:latitude, :longitude]
      property :upper_right_coordinate, :type => Hash, :required => true, :required_keys => [:latitude, :longitude]
      property :resolution,             :type => Numeric, :default => 5

      def execute
        validate

        response = soap_client.call(:lat_lon_list_subgrid, :message => build_message)
        document = parse_xml(response)
        transform_coordinate_list(document)
      end

      protected

      def build_message
        {
          :lowerLeftLatitude   => conditions[:lower_left_coordinate][:latitude],
          :lowerLeftLongitude  => conditions[:lower_left_coordinate][:longitude],
          :upperRightLatitude  => conditions[:upper_right_coordinate][:latitude],
          :upperRightLongitude => conditions[:upper_right_coordinate][:longitude],
          :resolution          => conditions[:resolution]
        }
      end

      def parse_xml(response)
        Nokogiri::XML(response.body[:lat_lon_list_subgrid_response][:list_lat_lon_out])
      end
    end
  end
end
