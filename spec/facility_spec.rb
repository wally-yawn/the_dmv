require 'spec_helper'

RSpec.describe Facility do
  before(:each) do
    @antique_model_year = Time.now.year - 26
    @facility = Facility.new({name: 'DMV Tremont Branch', address: '2855 Tremont Place Suite 118 Denver CO 80205', phone: '(720) 865-4600'})
    @antique_car = Vehicle.new({vin: '123456789abcdefgh', year: @antique_model_year - 50, make: 'Chevrolet', model: 'Cruz', engine: :ice})
    @normal_car = Vehicle.new({vin: '123456789abcdefgh', year: @antique_model_year + 1, make: 'Subaru', model: 'Outback', engine: :ice})
    @electric_car = Vehicle.new({vin: '123456789abcdefgh', year: @antique_model_year + 1, make: 'Nissan', model: 'Leaf', engine: :ev})
    @antique_electric_car = Vehicle.new({vin: '123456789abcdefgh', year: @antique_model_year, make: 'Nissan', model: 'Leaf', engine: :ev})

  end
  describe '#initialize' do
    it 'can initialize' do
      expect(@facility).to be_an_instance_of(Facility)
      expect(@facility.name).to eq('DMV Tremont Branch')
      expect(@facility.address).to eq('2855 Tremont Place Suite 118 Denver CO 80205')
      expect(@facility.phone).to eq('(720) 865-4600')
      expect(@facility.services).to eq([])
      expect(@facility.registered_vehicles).to eq([])
      expect(@facility.collected_fees).to eq(0)
    end
  end

  describe '#add service' do
    it 'can add available services' do
      expect(@facility.services).to eq([])
      @facility.add_service('New Drivers License')
      @facility.add_service('Renew Drivers License')
      @facility.add_service('Vehicle Registration')
      expect(@facility.services).to eq(['New Drivers License', 'Renew Drivers License', 'Vehicle Registration'])
    end
  end
  describe '#register_vehicle' do
    it 'can register an antique vehicle' do
      expect(@facility.registered_vehicles).to eq([])
      expect(@facility.collected_fees).to eq(0)
      expect(@antique_car.registration_date).to eq(nil)
      expect(@antique_car.plate_type).to eq(nil)
      @facility.register_vehicle(@antique_car)
      expect(@facility.registered_vehicles).to eq([@antique_car])
      expect(@facility.collected_fees).to eq(25)
      expect(@antique_car.registration_date).to eq(Date.today)
      expect(@antique_car.plate_type).to eq(:antique)
    end
    it 'can register an electric vehicle' do
      expect(@facility.registered_vehicles).to eq([])
      expect(@facility.collected_fees).to eq(0)
      expect(@electric_car.registration_date).to eq(nil)
      expect(@electric_car.plate_type).to eq(nil)
      @facility.register_vehicle(@electric_car)
      expect(@facility.registered_vehicles).to eq([@electric_car])
      expect(@facility.collected_fees).to eq(200)
      expect(@electric_car.registration_date).to eq(Date.today)
      expect(@electric_car.plate_type).to eq(:ev)
    end
    it 'can register a regular vehicle' do
      expect(@facility.registered_vehicles).to eq([])
      expect(@facility.collected_fees).to eq(0)
      expect(@normal_car.registration_date).to eq(nil)
      expect(@electric_car.plate_type).to eq(nil)
      @facility.register_vehicle(@normal_car)
      expect(@facility.registered_vehicles).to eq([@normal_car])
      expect(@facility.collected_fees).to eq(100)
      expect(@normal_car.registration_date).to eq(Date.today)
      expect(@normal_car.plate_type).to eq(:regular)
    end
    it 'can register an antique ev' do
      expect(@facility.registered_vehicles).to eq([])
      expect(@facility.collected_fees).to eq(0)
      expect(@antique_electric_car.registration_date).to eq(nil)
      expect(@antique_electric_car.plate_type).to eq(nil)
      @facility.register_vehicle(@antique_electric_car)
      expect(@facility.registered_vehicles).to eq([@antique_electric_car])
      expect(@facility.collected_fees).to eq(25)
      expect(@antique_electric_car.registration_date).to eq(Date.today)
      expect(@antique_electric_car.plate_type).to eq(:antique)
    end
    it 'can register multiple cars' do
      expect(@facility.registered_vehicles).to eq([])
      expect(@facility.collected_fees).to eq(0)
      @facility.register_vehicle(@antique_car)
      @facility.register_vehicle(@electric_car)
      @facility.register_vehicle(@normal_car)
      @facility.register_vehicle(@antique_electric_car)
      expect(@facility.registered_vehicles).to eq([@antique_car,@electric_car,@normal_car,@antique_electric_car])
      expect(@facility.collected_fees).to eq(350)
    end
  end
end
