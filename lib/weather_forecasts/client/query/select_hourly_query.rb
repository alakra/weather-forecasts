require 'dwml'

module WeatherForecasts
  class Client
    class SelectHourlyQuery < Query
      include QueryUtilities

      ENDPOINT = 'http://forecast.weather.gov/MapClick.php'

      property :latitude, :type => Numeric, :required => true
      property :longitude, :type => Numeric, :required => true

      def execute
        validate

        request = HTTPI::Request.new
        request.url = ENDPOINT
        request.query = build_message

        document = HTTPI.get(request)
        DWML.new( Nokogiri::XML(document.body) ).process
      end

      def build_message
        {
          :lat => conditions[:latitude],
          :lon => conditions[:longitude],
          :FcstType => 'digitalDWML'
        }
      end
    end
  end
end
