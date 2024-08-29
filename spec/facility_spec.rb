require 'spec_helper'

RSpec.describe Facility do
  before(:each) do
    @facility = Facility.new({name: 'DMV Tremont Branch', address: '2855 Tremont Place Suite 118 Denver CO 80205', phone: '(720) 865-4600'})
  end
  describe '#initialize' do
    it 'can initialize' do
      expect(@facility).to be_an_instance_of(Facility)
      expect(@facility.name).to eq('DMV Tremont Branch')
      expect(@facility.address).to eq('2855 Tremont Place Suite 118 Denver CO 80205')
      expect(@facility.phone).to eq('(720) 865-4600')
      expect(@facility.services).to eq([])
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
      #adds to registered_vehicles array
      #incremements collected_fees by $25
      #sets vehicle.registration_date
      #sets vehicle.plate_type to :antique
      expect(true).to eq false
    end
    it 'can register an electric vehicle' do
      #adds to registered_vehicles array
      #incremements collected_fees by $200
      #sets vehicle.registration_date
      #sets vehicle.plate_type to :ev
      expect(true).to eq false
    end
    it 'can register an other vehicle' do
      #adds to registered_vehicles array
      #incremements collected_fees by $100
      #sets vehicle.registration_date
      #sets vehicle.plate_type to :antique
      expect(true).to eq false
    end
  end
end
