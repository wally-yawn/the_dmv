require 'spec_helper'

RSpec.describe VehicleFactory do
  before(:each) do
    @vehicle_factory1 = VehicleFactory.new
    @wa_ev_registrations = DmvDataService.new.wa_ev_registrations
  end

  describe '#initialize' do
    it 'can initialize' do
      expect(@vehicle_factory1).to be_an_instance_of(VehicleFactory)
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
      expect(@vehicle_factory1.vehicles[0].county).to eq('King')
      expect(@vehicle_factory1.vehicles[0].registration_date).to eq(nil)
      expect(@vehicle_factory1.vehicles[0].plate_type).to eq(nil)
      expect(@vehicle_factory1.vehicles.length).to eq(1000)
    end
  end

  describe '#ev_registration_statistics' do
    before(:each) do
      @vehicle_factory1.create_vehicles(@wa_ev_registrations)
    end
      
    it 'can get most_popular make and model' do
      expect(@vehicle_factory1.most_popular_make_model_registered).to eq(["TESLA Model 3", 176])
    end
    it 'can get the registered vehicle for the given model year' do
      expect(@vehicle_factory1.vehicles_by_year('2023')).to eq(160)
      expect(@vehicle_factory1.vehicles_by_year('2024')).to eq(26)
    end
    it 'can get the county with the most registered vehicles' do
      expect(@vehicle_factory1.county_with_most_registered_vehicles).to eq(['King', 750])
    end
  end
end
