require 'spec_helper'

RSpec.describe Vehicle do
  before(:each) do
    @antique_model_year = Time.now.year - 26
    @cruz = Vehicle.new({vin: '123456789abcdefgh', year: @antique_model_year + 1, make: 'Chevrolet', model: 'Cruz', engine: :ice} )
    @bolt = Vehicle.new({vin: '987654321abcdefgh', year: Time.now.year + 1, make: 'Chevrolet', model: 'Bolt', engine: :ev} )
    @camaro = Vehicle.new({vin: '1a2b3c4d5e6f', year: @antique_model_year, make: 'Chevrolet', model: 'Camaro', engine: :ice} )
  end
  describe '#initialize' do
    it 'can initialize' do
      expect(@cruz).to be_an_instance_of(Vehicle)
      expect(@cruz.vin).to eq('123456789abcdefgh')
      expect(@cruz.year).to eq(@antique_model_year + 1)
      expect(@cruz.make).to eq('Chevrolet')
      expect(@cruz.model).to eq('Cruz')
      expect(@cruz.engine).to eq(:ice)
      expect(@cruz.registration_date).to eq(nil)
      expect(@cruz.plate_type).to eq(nil)
    end
  end

  describe '#antique?' do
    it 'can determine if a vehicle is an antique' do
      expect(@cruz.antique?).to eq(false)
      expect(@bolt.antique?).to eq(false)
      expect(@camaro.antique?).to eq(true)
    end
  end

  describe '#electric_vehicle?' do
    it 'can determine if a vehicle is an ev' do
      expect(@cruz.electric_vehicle?).to eq(false)
      expect(@bolt.electric_vehicle?).to eq(true)
      expect(@camaro.electric_vehicle?).to eq(false)
    end
  end

  describe '#set_plate_type' do
    it 'can set plate type' do
      expect(@cruz.plate_type).to eq(nil)
      expect(@bolt.plate_type).to eq(nil)
      expect(@camaro.plate_type).to eq(nil)
      @cruz.set_plate_type(:normal)
      @bolt.set_plate_type(:ev)
      @camaro.set_plate_type(:antique)
      expect(@cruz.plate_type).to eq(:normal)
      expect(@bolt.plate_type).to eq(:ev)
      expect(@camaro.plate_type).to eq(:antique)
    end
  end

  describe '#set_registration_date' do
    it 'can set registration_date' do
      expect(@cruz.registration_date).to eq(nil)
      @cruz.set_registration_date
      expect(@cruz.registration_date).to eq(Date.today.strftime("%Y-%m-%d"))
    end
  end
end
