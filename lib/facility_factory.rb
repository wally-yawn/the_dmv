class FacilityFactory
  attr_reader :facilities
  def initialize
    @facilities = []
  end

  def format_address(address_1, address_2, city, state, zip)
    if address_2 != nil
      "#{address_1} #{address_2} #{city} #{state} #{zip}"
    else
      "#{address_1} #{city} #{state} #{zip}"
    end
  end

  def create_co_facilities(co_facilities)
    co_facilities.each do |facility|
      name = facility[:dmv_office]
      address = format_address(facility[:address_li],facility[:address__1],facility[:city],facility[:state],facility[:zip])
      phone = facility[:phone]
      @facilities << Facility.new({name: name, address: address, phone: phone})
    end
  end

  def create_ny_facilities(ny_facilities)
    ny_facilities.each do |facility|
      name = facility[:office_name]
      address = format_address(facility[:street_address_line_1], facility[:street_address_line_2], facility[:city], facility[:state], facility[:zip_code])
      phone = facility[:public_phone_number]
      @facilities << Facility.new({name: name, address: address, phone: phone})
    end
  end

  def create_facilities(facilities)
    if facilities[0][:state] == 'CO'
      create_co_facilities(facilities)
    elsif facilities[0][:state] == 'NY'
      create_ny_facilities(facilities)
    end
  end
end