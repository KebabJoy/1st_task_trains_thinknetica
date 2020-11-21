class Route
	attr_reader :stations

	def initialize(start,finish)
		@stations = [start, finish]
	end

	def add_station(station)
		@stations.insert(-1, station)
	end

	def print_stations
		stations.each do |station|
			puts station
		end
	end
end
