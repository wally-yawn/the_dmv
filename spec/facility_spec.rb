require 'spec_helper'

RSpec.describe Facility do
  before(:each) do
    @antique_model_year = Time.now.year - 25
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
    before(:each) do
      @facility.add_service('Vehicle Registration')
    end

    it 'can register an antique vehicle' do
      @facility.add_service('Vehicle Registration')
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
      @facility.add_service('Vehicle Registration')
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
      @facility.add_service('Vehicle Registration')
      expect(@facility.registered_vehicles).to eq([])
      expect(@facility.collected_fees).to eq(0)
      expect(@normal_car.registration_date).to eq(nil)
      expect(@normal_car.plate_type).to eq(nil)
      @facility.register_vehicle(@normal_car)
      expect(@facility.registered_vehicles).to eq([@normal_car])
      expect(@facility.collected_fees).to eq(100)
      expect(@normal_car.registration_date).to eq(Date.today)
      expect(@normal_car.plate_type).to eq(:regular)
    end
    it 'can register an antique ev' do
      @facility.add_service('Vehicle Registration')
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
      @facility.add_service('Vehicle Registration')
      expect(@facility.registered_vehicles).to eq([])
      expect(@facility.collected_fees).to eq(0)
      @facility.register_vehicle(@antique_car)
      @facility.register_vehicle(@electric_car)
      @facility.register_vehicle(@normal_car)
      @facility.register_vehicle(@antique_electric_car)
      expect(@facility.registered_vehicles).to eq([@antique_car,@electric_car,@normal_car,@antique_electric_car])
      expect(@facility.collected_fees).to eq(350)
    end
    it 'cannot register cars if the facility does not have the vehicle_registration service' do
      @facility.services.delete('Vehicle Registration')
      expect(@facility.services).to eq([])
      expect(@facility.registered_vehicles).to eq([])
      puts @facility.services
      expect(@facility.collected_fees).to eq(0)
      @facility.register_vehicle(@antique_car)
      expect(@facility.registered_vehicles).to eq([])
      expect(@facility.collected_fees).to eq(0)
    end
  end

  describe '#administer_written_test' do
    before(:each) do
      @facility.add_service('Written Test')
      @facility2 = Facility.new({name: 'DMV Federal Branch', address: '123 Federal Suite 118 Denver CO 80205', phone: '(720) 865-1234'})
      @registrant1 = Registrant.new("Wally1", 16, true)
      @registrant2 = Registrant.new('Wally2', 15, true)
      @registrant3 = Registrant.new("Wally3", 16)
      @registrant4 = Registrant.new('Wally4', 15)
    end
    it 'can administer written test if the registrant is 16 or older and has a permit' do
      expect(@registrant1.license_data).to eq({:license=>false, :renewed=>false, :written=>false})
      expect(@facility.administer_written_test(@registrant1)).to eq(true)
      expect(@registrant1.license_data[:written]).to eq(true)
    end
    it 'cannot administer written test if the registrant is not 16 or older and has a permit' do
      expect(@registrant2.license_data).to eq({:license=>false, :renewed=>false, :written=>false})
      expect(@facility.administer_written_test(@registrant2)).to eq(false)
      expect(@registrant2.license_data[:written]).to eq(false)
    end
    it 'cannot administer written test if the registrant is 16 or older but has no permit' do
      expect(@registrant3.license_data).to eq({:license=>false, :renewed=>false, :written=>false})
      expect(@facility.administer_written_test(@registrant3)).to eq(false)
      expect(@registrant3.license_data[:written]).to eq(false)
    end
    it 'cannot administer written test if the registrant is not 16 or older and has no a permit' do
      expect(@registrant4.license_data).to eq({:license=>false, :renewed=>false, :written=>false})
      expect(@facility.administer_written_test(@registrant4)).to eq(false)
      expect(@registrant3.license_data[:written]).to eq(false)
    end
    it 'cannot administer written test if the registrant is 16 or older and has a permit but does not have the written test service' do
      expect(@registrant1.license_data).to eq({:license=>false, :renewed=>false, :written=>false})
      expect(@facility2.administer_written_test(@registrant1)).to eq(false)
      expect(@registrant1.license_data[:written]).to eq(false)
    end
  end

  describe '#administer_road_test' do
    before(:each) do
      @facility.add_service('Written Test')
      @facility.add_service('Road Test')
      @facility2 = Facility.new({name: 'DMV Federal Branch', address: '123 Federal Suite 118 Denver CO 80205', phone: '(720) 865-1234'})
      @registrant1 = Registrant.new("Wally1", 16, true)
      @registrant2 = Registrant.new('Wally2', 15, true)
      @facility.administer_written_test(@registrant1)
    end

    it 'can administer road test if the registrant has a written test' do
      expect(@registrant1.license_data).to eq({:license=>false, :renewed=>false, :written=>true})
      expect(@facility.administer_road_test(@registrant1)).to eq(true)
      expect(@registrant1.license_data[:license]).to eq(true)
    end

    it 'cannot administer road test if the registrant does not have a written test' do
      expect(@registrant2.license_data).to eq({:license=>false, :renewed=>false, :written=>false})
      expect(@facility.administer_road_test(@registrant2)).to eq(false)
      expect(@registrant2.license_data[:license]).to eq(false)
    end

    it 'cannot administer road test if the registrant has a written test but does not have the road test service' do
      expect(@registrant1.license_data).to eq({:license=>false, :renewed=>false, :written=>true})
      expect(@facility2.administer_written_test(@registrant1)).to eq(false)
      expect(@registrant1.license_data[:license]).to eq(false)
    end
  end

  describe 'renew_license' do
    before(:each) do
      @facility.add_service('Written Test')
      @facility.add_service('Road Test')
      @facility.add_service('Renew License')
      @facility2 = Facility.new({name: 'DMV Federal Branch', address: '123 Federal Suite 118 Denver CO 80205', phone: '(720) 865-1234'})
      @facility2.add_service('Written Test')
      @facility2.add_service('Road Test')
      @registrant1 = Registrant.new("Wally1", 16, true)
      @registrant2 = Registrant.new('Wally2', 16, true)
      @facility.administer_written_test(@registrant1)
      @facility.administer_written_test(@registrant2)
      @facility.administer_road_test(@registrant1)
    end

    it 'can renew license if the registrant already has a license' do
      expect(@registrant1.license_data).to eq({:license=>true, :renewed=>false, :written=>true})
      expect(@facility.renew_license(@registrant1)).to eq(true)
      expect(@registrant1.license_data).to eq(({:license=>true, :renewed=>true, :written=>true}))
    end

    it 'cannot renew license if the registrant does not have a license' do
      expect(@registrant2.license_data).to eq({:license=>false, :renewed=>false, :written=>true})
      expect(@facility.renew_license(@registrant2)).to eq(false)
      expect(@registrant2.license_data).to eq({:license=>false, :renewed=>false, :written=>true})
    end

    it 'cannot renew license if the registrant has a license but does not have the renew license service' do
      expect(@registrant1.license_data).to eq({:license=>true, :renewed=>false, :written=>true})
      expect(@facility2.renew_license(@registrant1)).to eq(false)
      expect(@registrant1.license_data).to eq({:license=>true, :renewed=>false, :written=>true})
    end
  end
end