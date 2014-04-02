module WeatherForecasts
  class Client
    class SelectCoordinatesByZipQuery < Query
      property :zip, :type => Array, :required => true

      def execute
        validate

        response = soap_client.call(:lat_lon_list_zip_code, :message => build_message)
        document = parse_xml(response)
        transform_document_to_mapped_list(document)
      end

      protected

      def build_message
        {
          :zipCodeList => conditions[:zip].join(" ")
        }
      end

      def parse_xml(response)
        Nokogiri::XML(response.body[:lat_lon_list_zip_code_response][:list_lat_lon_out])
      end

      def transform_document_to_mapped_list(document)
        document.xpath("//latLonList").text.split.each_with_index.inject({}) do |memo, (coord, i)|
          latitude, longitude = coord.split(",").map(&:to_f)
          memo.merge(conditions[:zip][i] => { :latitude => latitude, :longitude => longitude })
        end
      end
    end
  end
end
