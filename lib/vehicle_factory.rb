class VehicleFactory
  attr_reader :vehicles
  def initialize
    @vehicles = []
  end

  def create_vehicles(registrations)
    registrations.each do |registration|
      vin = registration[:vin_1_10]
      year = registration[:model_year]
      make = registration[:make]
      model = registration[:model]
      county = registration[:county]
      engine = :ev
      @vehicles << Vehicle.new({vin: vin, year: year, make: make, model: model, engine: engine, county: county})
    end
  end

  def most_popular_make_model_registered
    make_and_model_count = Hash.new(0)
    @vehicles.each do |vehicle|
      make_model = "#{vehicle.make} #{vehicle.model}"
      make_and_model_count[make_model] += 1
    end
    make_and_model_count.max_by { |key, value| value }
  end

  def vehicles_by_year(year)
    vehicles_in_year = @vehicles.find_all {|vehicle| vehicle.year == year}
    vehicles_in_year.length
  end

  def county_with_most_registered_vehicles
    county_count = Hash.new(0)
    @vehicles.each do |vehicle|
      county_count[vehicle.county] += 1
    end
    county_count.max_by { |key, value| value }
  end
end