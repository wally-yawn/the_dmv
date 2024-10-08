class Facility
  attr_reader :name, :address, :phone, :services, :registered_vehicles, :collected_fees, :hours_of_operation, :holidays_closed

  def initialize(facility_information)
    @name = facility_information[:name]
    @address = facility_information[:address]
    @phone = facility_information[:phone]
    @services = []
    @registered_vehicles = []
    @collected_fees = 0
    @hours_of_operation = facility_information[:hours_of_operation]
    @holidays_closed = facility_information[:holidays_closed]
  end

  def add_service(service)
    @services << service
  end

  def register_vehicle(vehicle)
    if @services.include?("Vehicle Registration")
      if vehicle.antique? == true
        @collected_fees += 25
        vehicle.set_plate_type(:antique)
        vehicle.set_registration_date
        @registered_vehicles << vehicle

      elsif vehicle.engine == :ev
        @collected_fees += 200
        vehicle.set_plate_type(:ev)
        vehicle.set_registration_date
        @registered_vehicles << vehicle

      else
        @collected_fees += 100
        vehicle.set_plate_type(:regular)
        vehicle.set_registration_date
        @registered_vehicles << vehicle
      end
    end
  end

  def administer_written_test(registrant)
    if registrant.age >= 16 && registrant.permit? == true && @services.include?("Written Test")
      registrant.license_data[:written] = true
      true
    else
      false
    end
  end

  def administer_road_test(registrant)
    if registrant.license_data[:written] == true && @services.include?("Road Test")
      registrant.license_data[:license] = true
      true
    else
      false
    end
  end

  def renew_drivers_license(registrant)
    if registrant.license_data[:license] == true && @services.include?("Renew License")
      registrant.license_data[:renewed] = true
      true
    else
      false
    end
  end
end