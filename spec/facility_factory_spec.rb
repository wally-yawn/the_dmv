require 'spec_helper'

RSpec.describe FacilityFactory do
  before(:each) do
    @facility_factory1 = FacilityFactory.new
    @co_locations = DmvDataService.new.co_dmv_office_locations
  end

  describe '#initialize' do
    it 'can initialize' do
      expect(@facility_factory1).to be_an_instance_of(FacilityFactory)
    end
  end

  describe '#create_facilities' do
    it 'can create co facilities' do
      expect(@facility_factory1.facilities).to eq([])
      @facility_factory1.create_facilities(@co_locations)
      expect(@facility_factory1.facilities[0]).to be_an_instance_of(Facility)
      expect(@facility_factory1.facilities[0].name).to eq('DMV Tremont Branch')
      expect(@facility_factory1.facilities[0].address).to eq('2855 Tremont Place Suite 118 Denver CO 80205')
      expect(@facility_factory1.facilities[0].phone).to eq('(720) 865-4600')
      expect(@facility_factory1.facilities[0].services).to eq([])
      expect(@facility_factory1.facilities[0].registered_vehicles).to eq([])
      expect(@facility_factory1.facilities[0].collected_fees).to eq(0)
      expect(@facility_factory1.facilities.length).to eq(5)
    end
  end
end