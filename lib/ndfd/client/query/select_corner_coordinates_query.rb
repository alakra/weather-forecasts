module NDFD
  class Client
    class SelectCornerCoordinatesQuery < Query
      include NDFD::Client::QueryUtilities

      SECTOR_GRID_OPTIONS = [
        :conus,
        :alaska,
        :nhemi,
        :guam,
        :hawaii,
        :puertori
      ]

      property :sector, :type => Symbol, :options => SECTOR_GRID_OPTIONS, :required => true

      def execute
        validate

        response = soap_client.call(:corner_points, :message => build_message)
        document = parse_xml(response)
        transform_coordinate_list(document)
      end

      protected

      def build_message
        {
          :sector   => conditions[:sector].to_s,
        }
      end

      def parse_xml(response)
        Nokogiri::XML(response.body[:corner_points_response][:list_lat_lon_out])
      end
    end
  end
end
