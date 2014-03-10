require 'active_support/time'
require 'active_support/time_with_zone'

Time.zone ||= "UTC"

require 'ndfd/client/response'
require 'ndfd/client/query/query_property'
require 'ndfd/client/query/selection_attributes'
require 'ndfd/client/query/query_utilities'

module NDFD
  class Client
    class Query
      FORECAST_ELEMENTS = {
        :maxt         => "Maximum Temperature",
        :mint         => "Minimum Temperature",
        :temp         => "3 Hourly Temperature",
        :dew          => "Dewpoint Temperature",
        :appt         => "Apparent Temperature",
        :pop12        => "12 Hour Probability of Precipitation",
        :qpf          => "Liquid Precipitation Amount",
        :snow         => "Snowfall Amount",
        :sky          => "Cloud Cover Amount",
        :rh           => "Relative Humidity",
        :wspd         => "Wind Speed",
        :wdir         => "Wind Direction",
        :wx           => "Weather",
        :icons        => "Weather Icons",
        :waveh        => "Wave Height",
        :incw34       => "Probabilistic Tropical Cyclone Wind Speed >34 Knots (Incremental)",
        :incw50       => "Probabilistic Tropical Cyclone Wind Speed >50 Knots (Incremental)",
        :incw64       => "Probabilistic Tropical Cyclone Wind Speed >64 Knots (Incremental)",
        :cumw34       => "Probabilistic Tropical Cyclone Wind Speed >34 Knots (Cumulative)",
        :cumw50       => "Probabilistic Tropical Cyclone Wind Speed >50 Knots (Cumulative)",
        :cumw64       => "Probabilistic Tropical Cyclone Wind Speed >64 Knots (Cumulative)",
        :wgust        => "Wind Gust",
        :critfireo    => "Fire Weather from Wind and Relative Humidity",
        :dryfireo     => "Fire Weather from Dry Thunderstorms",
        :conhazo      => "Convective Hazard Outlook",
        :ptornado     => "Probability of Tornadoes",
        :phail        => "Probability of Hail",
        :ptstmwinds   => "Probability of Damaging Thunderstorm Winds",
        :pxtornado    => "Probability of Extreme Tornadoes",
        :pxhail       => "Probability of Extreme Hail",
        :pxtstmwinds  => "Probability of Extreme Thunderstorm Winds",
        :ptotsvrtstm  => "Probability of Severe Thunderstorms",
        :pxtotsvrtstm => "Probability of Extreme Severe Thunderstorms",
        :tmpabv14d    => "Probability of 8- To 14-Day Average Temperature Above Normal",
        :tmpblw14d    => "Probability of 8- To 14-Day Average Temperature Below Normal",
        :tmpabv30d    => "Probability of One-Month Average Temperature Above Normal",
        :tmpblw30d    => "Probability of One-Month Average Temperature Below Normal",
        :tmpabv90d    => "Probability of Three-Month Average Temperature Above Normal",
        :tmpblw90d    => "Probability of Three-Month Average Temperature Below Normal",
        :prcpabv14d   => "Probability of 8- To 14-Day Total Precipitation Above Median",
        :prcpblw14d   => "Probability of 8- To 14-Day Total Precipitation Below Median",
        :prcpabv30d   => "Probability of One-Month Total Precipitation Above Median",
        :prcpblw30d   => "Probability of One-Month Total Precipitation Below Median",
        :prcpabv90d   => "Probability of Three-Month Total Precipitation Above Median",
        :prcpblw90d   => "Probability of Three-Month Total Precipitation Below Median",
        :precipa_r    => "Real-time Mesoscale Analysis Precipitation",
        :sky_r        => "Real-time Mesoscale Analysis GOES Effective Cloud Amount",
        :td_r         => "Real-time Mesoscale Analysis Dewpoint Temperature",
        :temp_r       => "Real-time Mesoscale Analysis Temperature",
        :wdir_r       => "Real-time Mesoscale Analysis Wind Direction",
        :wspd_r       => "Real-time Mesoscale Analysis Wind Speed",
        :wwa          => "Watches, Warnings, and Advisories",
        :iceaccum     => "Ice Accumulation",
        :maxrh        => "Maximum Relative Humidity",
        :minrh        => "Minimum Relative Humidity"
      }

      attr_reader :soap_client, :select_attributes, :conditions

      def initialize(soap_client, select_attributes = [])
        @soap_client = soap_client
        @select_attributes = select_attributes
        @conditions = {}
      end

      def where(params)
        conditions.merge!(params)
        set_defaults_as_needed

        self
      end

      def execute
        raise NotImplementedError, "Must be implemented in subclass."
      end

      def validate
        validate_selection_attributes
        validate_conditions
      end

      class << self
        def properties
          @@properties ||= {}
        end

        def property(attr, options = {})
          properties[self] ||= []
          properties[self] << QueryProperty.new(attr, options)
        end

        def selection_attributes
          @@selection_attributes ||= {}
        end

        def set_selection_attributes(*attrs)
          selection_attributes[self] = SelectionAttributes.new(attrs)
        end
      end

      protected

      def available_selections
        self.class.selection_attributes[self.class]
      end

      def set_defaults_as_needed
        query_properties = self.class.properties[self.class]
        return unless query_properties

        query_properties.select(&:default).each do |query_property|
          next if conditions.has_key?(query_property.name)
          conditions.merge!(query_property.name => query_property.default)
        end
      end

      def validate_selection_attributes
        select_attributes.each do |attr|
          available_selections && available_selections.valid?(attr)
        end
      end

      def validate_conditions
        query_properties = self.class.properties[self.class]
        return unless query_properties

        query_properties.each do |query_property|
          query_property.valid?(conditions)
        end
      end
    end
  end
end

require 'ndfd/client/query/select_gml_query'
require 'ndfd/client/query/select_gml_on_time_series_query'
require 'ndfd/client/query/select_by_days_query'
require 'ndfd/client/query/select_coordinates_by_cities_query'
require 'ndfd/client/query/select_coordinates_by_zip_query'
require 'ndfd/client/query/select_corner_coordinates_query'
require 'ndfd/client/query/select_gridpoint_coordinates_query'
require 'ndfd/client/query/select_linepoint_coordinates_query'
require 'ndfd/client/query/select_square_coordinates_query'
require 'ndfd/client/query/select_query'
