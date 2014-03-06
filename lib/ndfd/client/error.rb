module NDFD
  class Client
    class InvalidSelectionAttributeError < ArgumentError
    end

    class InvalidPropertyTypeError < ArgumentError
    end

    class InvalidOptionSpecifiedError < ArgumentError
    end

    class RequiredPropertyError < ArgumentError
    end

    class RequiredKeysMissingError < ArgumentError
    end
  end
end
