require 'spec_helper'

RSpec.describe Vehicle_factory do
  before(:each) do
    @vehicle_factory1 = Vehicle_factory.new
  end

  describe '#initialize' do
    it 'can initialize' do
      expect(@vehicle_factory1).to be_an_instance_of(Vehicle_factory)
    end
  end
end