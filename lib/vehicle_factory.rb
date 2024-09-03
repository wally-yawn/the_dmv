class VehicleFactory
  attr_reader :vehicles
  def initialize
    @vehicles = []
  end

  def create_vehicles(registrations)
    
    registrations.each do |registration|
      #require 'pry'; binding.pry
      vin = registration[:vin_1_10]
      year = registration[:model_year]
      make = registration[:make]
      model = registration[:model]
      engine = :ev
      @vehicles << Vehicle.new({vin: vin, year: year, make: make, model: model, engine: engine})
    end
  end
end