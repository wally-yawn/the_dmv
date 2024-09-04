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
      hours_of_operation = facility[:hours]
      @facilities << Facility.new({name: name, address: address, phone: phone, hours_of_operation: hours_of_operation})
    end
  end

  def create_ny_facilities(ny_facilities)
    ny_facilities.each do |facility|
      name = facility[:office_name]
      address = format_address(facility[:street_address_line_1], facility[:street_address_line_2], facility[:city], facility[:state], facility[:zip_code])
      phone = facility[:public_phone_number]
      m_hours = "M #{facility[:monday_beginning_hours]} - #{facility[:monday_ending_hours]}"
      t_hours = "T #{facility[:tuesday_beginning_hours]} - #{facility[:tuesdat_hours]}"
      w_hours = "W #{facility[:wednesday_beginning_hours]} - #{facility[:wednesday_ending_hours]}"
      r_hours = "R #{facility[:thursday_beginning_hours]} - #{facility[:thursday_ending_hours]}"
      f_hours = "F #{facility[:friday_beginning_hours]} - #{facility[:friday_ending_hours]}"
      hours_of_operation = "#{m_hours} #{t_hours} #{w_hours} #{r_hours} #{f_hours}"
      @facilities << Facility.new({name: name, address: address, phone: phone, hours_of_operation: hours_of_operation})
    end
  end

  def create_mo_facilities(mo_facilities)
    mo_facilities.each do |facility|
      name = facility[:name]
      address = format_address(facility[:address1],nil,facility[:city],facility[:state],facility[:zipcode])
      phone = facility[:phone]
      hours_of_operation = facility[:daysopen]
      holidays_closed = facility[:holidaysclosed]
      @facilities << Facility.new({name: name, address: address, phone: phone, hours_of_operation: hours_of_operation, holidays_closed: holidays_closed})
    end
  end

  def create_facilities(facilities)
    if facilities[0][:state] == 'CO'
      create_co_facilities(facilities)
    elsif facilities[0][:state] == 'NY'
      create_ny_facilities(facilities)
    elsif facilities[0][:state] == 'MO'
      create_mo_facilities(facilities)
    end
  end
end