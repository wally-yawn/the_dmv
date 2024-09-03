require 'spec_helper'

RSpec.describe Vehicle_factory do
  before(:each) do
    @vehicle_factory1 = Vehicle_factory.new
    @wa_ev_registrations = DmvDataService.new.wa_ev_registrations
  end

  describe '#initialize' do
    it 'can initialize' do
      expect(@vehicle_factory1).to be_an_instance_of(Vehicle_factory)
    end
  end

  describe '#create_vehicles' do
    it 'can create wa vehicles' do
      expect(@vehicle_factory1.vehicles).to eq([])
      @vehicle_factory1.create_vehicles(@wa_ev_registrations)
      expect(@vehicle_factory1.vehicles[0]).to be_an_instance_of(Vehicle)
      expect(@vehicle_factory1.vehicles[0].vin).to eq('5YJYGDED6M')
      expect(@vehicle_factory1.vehicles[0].year).to eq('2021')
      expect(@vehicle_factory1.vehicles[0].make).to eq('TESLA')
      expect(@vehicle_factory1.vehicles[0].model).to eq('Model Y')
      expect(@vehicle_factory1.vehicles[0].engine).to eq(:ev)
      expect(@vehicle_factory1.vehicles[0].registration_date).to eq(nil)
      expect(@vehicle_factory1.vehicles[0].plate_type).to eq(nil)
    end
  end
end