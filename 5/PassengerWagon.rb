require_relative 'wagon'

class PassengerWagon < Wagon

  def initialize(company,capacity)
    super(company)
    @type = :passenger
    @capacity = capacity
    @capacity_left = capacity
  end

  def take_a_sit
    @capacity_left -= 1 if @capacity_left > 0
  end

  def occupied_places
    @capacity - @capacity_left
  end
end

