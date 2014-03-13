module NDFD
  class Client
    class SelectByDaysQuery < Query
      include NDFD::Client::QueryUtilities

      property :coordinates, :type => Array, :required => true, :required_keys => [:latitude, :longitude]
      property :days,        :type => Fixnum, :required => true

      property :unit,        :type => String, :options => ["e", "m"], :default => "e"
      property :format,      :type => String, :options => ["24 hourly", "12 hourly"], :default => "24 hourly"

      property :start_date,  :type => ActiveSupport::TimeWithZone

      def execute
        validate

        response = soap_client.call(:ndf_dgen_by_day_lat_lon_list, :message => build_message)
        document = Nokogiri::XML(response.body[:ndf_dgen_by_day_lat_lon_list_response][:dwml_by_day_out])
        NDFD::DWML.new(document).process
      end

      protected

      def build_message
        {
          :listLatLong => build_coordinates(conditions[:coordinates]),
          :startDate   => conditions[:start_date].iso8601,
          :numDay      => conditions[:days],
          :Unit        => conditions[:unit],
          :format      => conditions[:format]
        }
      end
    end
  end
end
