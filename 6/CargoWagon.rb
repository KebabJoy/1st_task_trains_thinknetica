require_relative 'wagon'

class CargoWagon < Wagon

  def initialize(company,capacity)
    super(company)
    @type = :cargo
    @capacity = capacity
    @capacity_left = capacity
  end

  def fill(weight)
    @capacity_left -= weight if @capacity_left > weight
  end

  def filled
    @capacity - @capacity_left
  end
end
