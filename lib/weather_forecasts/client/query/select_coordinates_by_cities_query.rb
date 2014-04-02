module WeatherForecasts
  class Client
    class SelectCoordinatesByCitiesQuery < Query
      CITY_OPTIONS = {
        :all                    => 1234,
        :primary                => 1,
        :secondary              => 2,
        :tertiary               => 3,
        :quaternary             => 4,
        :primary_and_secondary  => 12,
        :tertiary_and_quaternar => 34
      }

      property :display, :type => Symbol, :options => CITY_OPTIONS.keys, :required => true

      def execute
        validate

        response = soap_client.call(:lat_lon_list_city_names, :message => build_message)
        document = parse_xml(response)
        transform_document_to_mapped_list(document)
      end

      protected

      def build_message
        {
          :displayLevel => CITY_OPTIONS[conditions[:display]]
        }
      end

      def parse_xml(response)
        Nokogiri::XML(response.body[:lat_lon_list_city_names_response][:list_lat_lon_out])
      end

      def transform_document_to_mapped_list(document)
        cities = document.xpath("//cityNameList").text.split('|')
        coords = document.xpath("//latLonList").text.split

        results = [cities, coords].transpose.inject({}) do |memo, (city, coord)|
          latitude, longitude = coord.split(",").map(&:to_f)
          memo.merge(city => { :latitude => latitude, :longitude => longitude } )
        end
      end
    end
  end
end
