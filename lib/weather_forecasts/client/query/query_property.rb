module WeatherForecasts
  class Client
    class QueryProperty
      attr_accessor :name, :type, :options, :required_keys, :required, :default

      def initialize(attr, parameters = {})
        @name          = attr
        @default       = parameters[:default]
        @options       = parameters[:options]
        @type          = parameters[:type] || String
        @required      = parameters[:required] || false
        @required_keys = parameters[:required_keys] || []
      end

      def valid?(conditions)
        @conditions = conditions

        validate_required
        validate_type
        validate_required_keys
        validate_options
      end

      protected

      def validate_required
        if required && @conditions[name.to_sym].blank?
          raise RequiredPropertyError, "The property, #{name.to_s}, is required."
        end
      end

      def validate_type
        unless @conditions[name.to_sym].is_a?(type)
          raise InvalidPropertyTypeError, "The type for #{name} should be an instance of #{type.to_s}."
        end
      end

      def validate_required_keys
        return if required_keys.blank?
        params_sets = @conditions[name.to_sym]

        if params_sets.present? && params_sets.is_a?(Array)
          params_sets.each { |hsh| check_required_keys_missing(hsh.keys) }
        elsif params_sets.present? && params_sets.is_a?(Hash)
          check_required_keys_missing(params_sets.keys)
        else
          raise_required_keys_missing_error(required_keys)
        end
      end

      def validate_options
        value = @conditions[name.to_sym]
        if options.present? && !options.include?(value)
          raise InvalidOptionSpecifiedError, "The option, #{value}, is not valid.  Please use one of the following: #{options.join(', ')}"
        end
      end

      def check_required_keys_missing(keys)
        missing_keys = required_keys - keys
        raise_required_keys_missing_error(missing_keys) if missing_keys.present?
      end

      def raise_required_keys_missing_error(missing_keys)
        raise RequiredKeysMissingError, "Required keys (#{missing_keys.join(', ')}) are missing for one of the data points (also, they must be in an Array)."
      end
    end
  end
end
