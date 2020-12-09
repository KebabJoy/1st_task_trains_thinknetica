require_relative 'modules'

class Route
  include InstanceCounter
  attr_reader :stations

  def initialize(start,finish)
    @stations = [start, finish]
    register_instance
  end

  def add_station(station)
    @stations.insert(-1, station)
  end

  def delete_station(station)
    @stations.delete(station)
  end
end

#clear
