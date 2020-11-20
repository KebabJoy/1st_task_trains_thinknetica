class Route
	attr_reader :stations

	def initialize(start,finish)
		@stations = []
		@stations << finish
		@stations.unshift(start)
	end

	def add_station(station)
		@stations.insert(stations.index(stations.last-1,station))
	end

	def print_stations
		stations.each do |station|
			puts station
		end
	end
end
