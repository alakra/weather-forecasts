require 'spec_helper'

describe WeatherForecasts::Client::SelectionAttributes do
  let(:attr) { :blah }

  subject { WeatherForecasts::Client::SelectionAttributes.new(attr) }

  describe "#valid?" do
    it "raises an error if an invalid selection attribute is used" do
      expect { subject.valid?(:wrong) }.to raise_error(WeatherForecasts::Client::InvalidSelectionAttributeError)
    end
  end
end
