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
      expect(@facility.register_vehicles).to eq([])
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
      expect(@antique_car.registration_date).to eq(Date.today.strftime("%Y-%m-%d"))
      expect(@antique_car.plate_type).to eq(:antique)
    end
    xit 'can register an electric vehicle' do
      #adds to registered_vehicles array
      #incremements collected_fees by $200
      #sets vehicle.registration_date
      #sets vehicle.plate_type to :ev
      expect(true).to eq false
    end
    xit 'can register an other vehicle' do
      #adds to registered_vehicles array
      #incremements collected_fees by $100
      #sets vehicle.registration_date
      #sets vehicle.plate_type to :antique
      expect(true).to eq false
    end
    xit 'can register an antique ev' do
      #adds to registered_vehicles array
      #incremements collected_fees by $25
      #sets vehicle.registration_date
      #sets vehicle.plate_type to :antique
      expect(true).to eq false
    end
  end
end
