require 'active_support/core_ext/array/wrap'

module WeatherForecasts
  class Client
    class SelectionAttributes
      attr_reader :attributes

      def initialize(attributes)
        @attributes = Array.wrap(attributes)
      end

      def valid?(attr)
        unless attributes.include?(attr)
          raise InvalidSelectionAttributeError, "The selection attribute, `#{attr}`, is not a valid attribute on this query."
        end
      end
    end
  end
end
