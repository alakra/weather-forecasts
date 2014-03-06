module NDFD
  class Client
    class SelectGmlOnTimeSeriesQuery < Query
      include NDFD::Client::QueryUtilities

      COMPARISON_OPTIONS = {
        :between               => "Between",
        :greater_than          => "GreaterThan",
        :less_than             => "LessThan",
        :greater_than_or_equal => "GreaterThanOrEqual",
        :less_than_or_equal    => "LessThanOrEqual",
        :equal                 => "isEqual"
      }

      set_selection_attributes *FORECAST_ELEMENTS.keys

      property :coordinates, :type => Array, :required => true, :required_keys => [:latitude, :longitude]
      property :start_time,  :type => ActiveSupport::TimeWithZone, :required => true
      property :end_time,    :type => ActiveSupport::TimeWithZone, :required => true
      property :comparison,  :type => Symbol, :options => COMPARISON_OPTIONS.keys, :required => true, :default => :between
      property :feature,     :type => String, :options => NDFD::Client::SelectGmlQuery::FEATURE_OPTIONS.keys, :required => true

      def execute
        validate

        response = soap_client.call(:gml_time_series, :message => build_message)
        Nokogiri::XML(response.body[:gml_time_series_response][:dw_gml_out])
      end

      protected

      def build_message
        {
          :listLatLon   => build_coordinates(conditions[:coordinates]),
          :startTime    => conditions[:start_time].iso8601,
          :endTime      => conditions[:end_time].iso8601,
          :compType     => COMPARISON_OPTIONS[conditions[:comparison]],
          :featureType  => conditions[:feature],
          :propertyName => build_weather_parameters
        }
      end

      def build_weather_parameters
        select_attributes.map(&:to_s).join(",")
      end
    end
  end
end
