class Dmv
  attr_reader :facilities

  def initialize
    @facilities = []
  end

  def add_facility(facility)
    @facilities << facility
  end

  def facilities_offering_service(service)
    facilities_offering_service = []
    @facilities.find_all do |facility|
      if facility.services.include?(service)
        facilities_offering_service << facility
      end
    end
    facilities_offering_service
  end
end
