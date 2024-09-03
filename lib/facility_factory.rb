class FacilityFactory
  attr_reader :facilities
  def initialize
    @facilities = []
  end

  def create_facilities(facilities)
    
    facilities.each do |facility|
      name = facility[:dmv_office]
      address = "#{facility[:address_li]} #{facility[:address__1]} #{facility[:city]} #{facility[:state]} #{facility[:zip]}"
      phone = facility[:phone]
      @facilities << Facility.new({name: name, address: address, phone: phone})
    end
  end
end