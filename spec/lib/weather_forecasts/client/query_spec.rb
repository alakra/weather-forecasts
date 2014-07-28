require 'spec_helper'

class WeatherForecasts::Client::TestQuery < WeatherForecasts::Client::Query
  set_selection_attributes :thing1, :thing2

  property :property1, :type => Array,  :required => true, :required_keys => [:lat, :long]
  property :property2, :type => String, :required => true, :options => ["one", "two"], :default => "one"
end

describe WeatherForecasts::Client::Query do
  let(:soap_client) { double }
  let(:attrs) { {} }
  let(:subclass) { WeatherForecasts::Client::TestQuery }

  let(:conditions_with_defaults) { {
      :property1 => [{ :lat => 67.87, :long => -107.37 }]
    }
  }

  let(:conditions_overriding_defaults) { {
      :property1 => [{ :lat => 67.87, :long => -107.37 }],
      :property2 => "two"
    }
  }

  subject { subclass.new(soap_client, attrs) }

  describe "#where" do
    it "updates the #conditions attributes and sets any defaults that aren't set" do
      subject.where(conditions_with_defaults)
      subject.conditions.should == conditions_with_defaults.merge(:property2 => "one")
    end

    it "does not set a conditions to a default value if it is already set" do
      subject.where(conditions_overriding_defaults)
      subject.conditions.should == conditions_overriding_defaults
    end

    it "returns self" do
      subject.where(conditions_overriding_defaults).should be_a(subclass)
    end
  end

  describe "#execute" do
    it "raises a not implemented error (intended for subclasses)" do
      expect { subject.execute }.to raise_error(NotImplementedError)
    end
  end

  describe "#validate" do
    context "for selection attributes" do
      context "with valid selection attributes" do
        it "validates that the selection attributes are appropriately set" do
          instance = subclass.new(soap_client, [:thing1, :thing2])
          instance.where(conditions_with_defaults)

          expect { instance.validate }.not_to raise_error
        end
      end

      context "with invalid selection attributes" do
        it "raises an error" do
          instance = subclass.new(soap_client, [:thing1, :thing2, :thing3])
          instance.where(conditions_with_defaults)

          expect { instance.validate }.to raise_error(WeatherForecasts::Client::InvalidSelectionAttributeError)
        end
      end
    end

    context "for conditions" do
      context "with valid conditions" do
        it "validates that the conditions are appropriately set" do
          instance = subclass.new(soap_client)
          instance.where(conditions_with_defaults)

          expect { instance.validate }.not_to raise_error
        end
      end

      context "with invalid conditions" do
        it "raises an error" do
          instance = subclass.new(soap_client)
          instance.where(conditions_with_defaults.merge(:property2 => "blah"))

          expect { instance.validate }.to raise_error(WeatherForecasts::Client::InvalidOptionSpecifiedError)
        end
      end
    end
  end
end
