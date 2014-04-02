require 'spec_helper'

describe WeatherForecasts::Client::QueryProperty do
  let(:name) { :thing }
  let(:klass) { WeatherForecasts::Client::QueryProperty }

  subject { klass.new(name) }

  describe "#initialize" do
    it "sets the appropriate defaults" do
      subject.name.should == name
      subject.type.should == String
      subject.options.should be_nil
      subject.default.should be_nil
      subject.required.should be_false
      subject.required_keys.should be_empty
    end
  end

  describe "#valid?" do
    it "raises an error on failure to validate required values" do
      instance = klass.new(name, :required => true)
      expect { instance.valid?({}) }.to raise_error(WeatherForecasts::Client::RequiredPropertyError)
    end

    it "raises an error on failure to validate matching types" do
      instance = klass.new(name, :type => String)
      expect { instance.valid?(name => 5) }.to raise_error(WeatherForecasts::Client::InvalidPropertyTypeError)
    end

    it "raises an error on failure to validate required keys" do
      instance = klass.new(name, :type => Array, :required_keys => [:lat, :long])
      expect { instance.valid?(name => []) }.to raise_error(WeatherForecasts::Client::RequiredKeysMissingError)
    end

    it "raises an error on failure to validate the correct use of a set of options" do
      instance = klass.new(name, :type => String, :options => ["one", "two"])
      expect { instance.valid?(name => "three") }.to raise_error(WeatherForecasts::Client::InvalidOptionSpecifiedError)
    end
  end
end
