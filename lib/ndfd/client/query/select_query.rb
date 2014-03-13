module NDFD
  class Client
    class SelectQuery < Query
      include NDFD::Client::QueryUtilities

      set_selection_attributes *FORECAST_ELEMENTS.keys

      property :coordinates, :type => Array, :required => true, :required_keys => [:latitude, :longitude]
      property :product,     :type => String, :options => ["time-series", "glance"], :required => true, :default => "time-series"
      property :unit,        :type => String, :options => ["e", "m"], :default => "e"

      property :start_time,  :type => ActiveSupport::TimeWithZone
      property :end_time,    :type => ActiveSupport::TimeWithZone

      def execute
        validate

        response = soap_client.call(:ndf_dgen_lat_lon_list, :message => build_message)
        document = Nokogiri::XML(response.body[:ndf_dgen_lat_lon_list_response][:dwml_out])
        transform_to_hash(document)
      end

      protected

      def transform_to_hash(doc)
        NDFD::DWML.new(doc).process
      end

      def build_message
        {
          :listLatLon        => build_coordinates(conditions[:coordinates]),
          :product           => conditions[:product],
          :startTime         => conditions[:start_time].iso8601,
          :endTime           => conditions[:end_time].iso8601,
          :Unit              => conditions[:unit],
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
