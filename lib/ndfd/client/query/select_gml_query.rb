module NDFD
  class Client
    class SelectGmlQuery < Query
      include NDFD::Client::QueryUtilities

      FEATURE_OPTIONS = {
 	"Forecast_Gml2Point"     => "GML 2 Compliant Data Structure",
        "Forecast_GmlsfPoint"    => "GML 3 Compliant Data Structures",
        "Forecast_GmlObs"        => "GML 3 Compliant Data Structures",
        "NdfdMultiPointCoverage" => "GML 3 Compliant Data Structures",
        "Ndfd_KmlPoint"          => "KML 2 Compliant Data Structure"
      }

      set_selection_attributes *FORECAST_ELEMENTS.keys

      property :feature,        :type => String, :options => FEATURE_OPTIONS.keys, :required => true
      property :coordinates,    :type => Array, :required => true, :required_keys => [:latitude, :longitude]
      property :requested_time, :type => ActiveSupport::TimeWithZone, :required => true

      def execute
        validate

        response = soap_client.call(:gml_lat_lon_list, :message => build_message)
        Nokogiri::XML(response.body[:gml_lat_lon_list_response][:dw_gml_out])
      end

      protected

      def build_message
        {
          :listLatLon        => build_coordinates(conditions[:coordinates]),
          :requestedTime     => conditions[:requested_time].iso8601,
          :featureType       => conditions[:feature],
          :weatherParameters => build_weather_parameters
        }
      end

      def build_weather_parameters
        available_selections.attributes.inject({}) do |memo, attr|
          is_requested = select_attributes.include?(attr) ? 1 : 0
          memo.merge!(attr => is_requested)
        end
      end
    end
  end
end
