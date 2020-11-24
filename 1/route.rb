class Route
  attr_reader :stations

  def initialize(start,finish)
    @stations = [start, finish]
  end

  def add_station(station)
    @stations.insert(-1, station)
  end
end

#clear
