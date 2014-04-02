module WeatherForecasts
  class Client
    class SelectSquareCoordinatesQuery < Query
      include QueryUtilities

      property :center_point, :type => Hash, :required => true, :required_keys => [:latitude, :longitude]
      property :distance,     :type => Hash, :required => true, :required_keys => [:latitude, :longitude]
      property :resolution,   :type => Numeric, :default => 5

      def execute
        validate

        response = soap_client.call(:lat_lon_list_square, :message => build_message)
        document = parse_xml(response)
        transform_coordinate_list(document)
      end

      protected

      def build_message
        {
          :centerPointLat => conditions[:center_point][:latitude],
          :centerPointLon => conditions[:center_point][:longitude],
          :distanceLat    => conditions[:distance][:latitude],
          :distanceLon    => conditions[:distance][:longitude],
          :resolution     => conditions[:resolution]
        }
      end

      def parse_xml(response)
        Nokogiri::XML(response.body[:lat_lon_list_square_response][:list_lat_lon_out])
      end
    end
  end
end
