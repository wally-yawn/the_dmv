require 'spec_helper'

RSpec.describe Registrant do
   before(:each) do
     @registrant1 = Registrant.new("Wally",29)
     @registrant2 = Registrant.new("Dahlia",15,true)
   end
  describe '#initialize' do
    it 'can initialize with no permit passed in' do
      expect(@registrant1).to be_an_instance_of(Registrant)
      expect(@registrant1.name).to eq("Wally")
      expect(@registrant1.age).to eq(29)
      expect(@registrant1.permit?).to eq(false)
      expect(@registrant1.license_data).to eq({:written=>false, :license=>false, :renewed=>false})
    end
    
    it 'can initialize with a permit passed in' do
      expect(@registrant2).to be_an_instance_of(Registrant)
      expect(@registrant2.name).to eq("Dahlia")
      expect(@registrant2.age).to eq(15)
      expect(@registrant2.permit?).to eq(true)
      expect(@registrant2.license_data).to eq({:written=>false, :license=>false, :renewed=>false})
    end
  end
  describe 'earn_permit' do
    it 'can earn a permit' do
      expect(@registrant1.permit?).to eq(false)
      @registrant1.earn_permit
      expect(@registrant1.permit?).to eq(true)
    end
  end
end