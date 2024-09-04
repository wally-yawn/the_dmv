require 'spec_helper'

RSpec.describe FacilityFactory do
  before(:each) do
    @facility_factory1 = FacilityFactory.new
    @co_locations = DmvDataService.new.co_dmv_office_locations
    @ny_locations = DmvDataService.new.ny_dmv_office_locations
    @mo_locations = DmvDataService.new.mo_dmv_office_locations
  end

  describe '#initialize' do
    it 'can initialize' do
      expect(@facility_factory1).to be_an_instance_of(FacilityFactory)
    end
  end

  describe '#format_address' do
    it "can format an address with a 2nd street address" do
      address = @facility_factory1.format_address("add1", "add2", "city", "state", "zip")
      expect(address).to eq("add1 add2 city state zip")
    end

    it "can format an address without a 2nd street address" do
      address = @facility_factory1.format_address("add1", nil, "city", "state", "zip")
      expect(address).to eq("add1 city state zip")
    end
  end

  describe '#create_co_facilities' do
    it 'can create co facilities_directly' do
      expect(@facility_factory1.facilities).to eq([])
      @facility_factory1.create_co_facilities(@co_locations)
      expect(@facility_factory1.facilities[0]).to be_an_instance_of(Facility)
      expect(@facility_factory1.facilities[0].name).to eq('DMV Tremont Branch')
      expect(@facility_factory1.facilities[0].address).to eq('2855 Tremont Place Suite 118 Denver CO 80205')
      expect(@facility_factory1.facilities[0].phone).to eq('(720) 865-4600')
      expect(@facility_factory1.facilities[0].hours_of_operation).to eq('Mon, Tue, Thur, Fri  8:00 a.m.- 4:30 p.m. / Wed 8:30 a.m.-4:30 p.m.')
      expect(@facility_factory1.facilities[0].services).to eq([])
      expect(@facility_factory1.facilities[0].registered_vehicles).to eq([])
      expect(@facility_factory1.facilities[0].collected_fees).to eq(0)
      expect(@facility_factory1.facilities.length).to eq(5)
    end
  end

  describe '#create_ny_facilities' do
    it 'can create ny facilities_directly' do
      expect(@facility_factory1.facilities).to eq([])
      @facility_factory1.create_ny_facilities(@ny_locations)
      expect(@facility_factory1.facilities[0]).to be_an_instance_of(Facility)
      expect(@facility_factory1.facilities[0].name).to eq('HUDSON')
      expect(@facility_factory1.facilities[0].address).to eq('560 WARREN STREET HUDSON NY 12534')
      expect(@facility_factory1.facilities[0].phone).to eq('5188283350')
      expect(@facility_factory1.facilities[0].hours_of_operation).to eq('M 9:00 AM - 4:45 PM T 9:00 AM -  W 9:00 AM - 4:45 PM R 9:00 AM - 6:45 PM F 9:00 AM - 4:45 PM')
      expect(@facility_factory1.facilities[0].services).to eq([])
      expect(@facility_factory1.facilities[0].registered_vehicles).to eq([])
      expect(@facility_factory1.facilities[0].collected_fees).to eq(0)
      expect(@facility_factory1.facilities.length).to eq(172)
    end
  end

  describe '#create_mo_facilities' do
    it 'can create mo facilities_directly' do
      expect(@facility_factory1.facilities).to eq([])
      @facility_factory1.create_mo_facilities(@mo_locations)
      expect(@facility_factory1.facilities[0]).to be_an_instance_of(Facility)
      expect(@facility_factory1.facilities[0].name).to eq('OAKVILLE')
      expect(@facility_factory1.facilities[0].address).to eq('3164 TELEGRAPH ROAD ST LOUIS MO 63125')
      expect(@facility_factory1.facilities[0].phone).to eq('(314) 887-1050')
      expect(@facility_factory1.facilities[0].hours_of_operation).to eq('Monday-Friday - 9:00 to 5:00, Last Saturday  - 9:00 to 12:00')
      expect(@facility_factory1.facilities[0].services).to eq([])
      expect(@facility_factory1.facilities[0].registered_vehicles).to eq([])
      expect(@facility_factory1.facilities[0].collected_fees).to eq(0)
      expect(@facility_factory1.facilities.length).to eq(178)
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
      expect(@facility_factory1.facilities[0].hours_of_operation).to eq('Mon, Tue, Thur, Fri  8:00 a.m.- 4:30 p.m. / Wed 8:30 a.m.-4:30 p.m.')
      expect(@facility_factory1.facilities[0].services).to eq([])
      expect(@facility_factory1.facilities[0].registered_vehicles).to eq([])
      expect(@facility_factory1.facilities[0].collected_fees).to eq(0)
      expect(@facility_factory1.facilities.length).to eq(5)
    end

    it 'can create ny facilities' do
      expect(@facility_factory1.facilities).to eq([])
      @facility_factory1.create_facilities(@ny_locations)
      expect(@facility_factory1.facilities[1]).to be_an_instance_of(Facility)
      expect(@facility_factory1.facilities[1].name).to eq('ROCHESTER DOWNTOWN')
      expect(@facility_factory1.facilities[1].address).to eq('200 E. MAIN STREET STE. 101 ROCHESTER NY 14604')
      expect(@facility_factory1.facilities[1].phone).to eq('5852594526')
      expect(@facility_factory1.facilities[0].hours_of_operation).to eq('M 9:00 AM - 4:45 PM T 9:00 AM -  W 9:00 AM - 4:45 PM R 9:00 AM - 6:45 PM F 9:00 AM - 4:45 PM')
      expect(@facility_factory1.facilities[1].services).to eq([])
      expect(@facility_factory1.facilities[1].registered_vehicles).to eq([])
      expect(@facility_factory1.facilities[1].collected_fees).to eq(0)
      expect(@facility_factory1.facilities.length).to eq(172)
    end

    it 'can create mo facilities' do
      expect(@facility_factory1.facilities).to eq([])
      @facility_factory1.create_facilities(@mo_locations)
      expect(@facility_factory1.facilities[0]).to be_an_instance_of(Facility)
      expect(@facility_factory1.facilities[0].name).to eq('OAKVILLE')
      expect(@facility_factory1.facilities[0].address).to eq('3164 TELEGRAPH ROAD ST LOUIS MO 63125')
      expect(@facility_factory1.facilities[0].phone).to eq('(314) 887-1050')
      expect(@facility_factory1.facilities[0].hours_of_operation).to eq('Monday-Friday - 9:00 to 5:00, Last Saturday  - 9:00 to 12:00')
      expect(@facility_factory1.facilities[0].services).to eq([])
      expect(@facility_factory1.facilities[0].registered_vehicles).to eq([])
      expect(@facility_factory1.facilities[0].collected_fees).to eq(0)
      expect(@facility_factory1.facilities.length).to eq(178)
    end
  end
end