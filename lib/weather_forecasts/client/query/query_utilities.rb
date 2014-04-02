module WeatherForecasts
  class Client
    module QueryUtilities
      def build_coordinates(coordinates)
        coordinates.map { |hsh| "#{hsh[:latitude]},#{hsh[:longitude]}" }.join(" ")
      end

      def transform_coordinate_list(document)
        document.xpath("//latLonList").text.split.map do |coord|
          latitude, longitude = coord.split(",").map(&:to_f)
          { :latitude => latitude, :longitude => longitude }
        end
      end
    end
  end
end
