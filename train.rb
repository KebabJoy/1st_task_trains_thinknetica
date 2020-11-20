class Train
	attr_accessor :speed
	attr_reader :type; :number; :wagons_count; :route; :current_station

	def initialize(type, num, wagons)
		@type = type
		@number = num
		@wagons_count = wagons
		@speed = 0
	end

	def set_route(route)
		@route = route
		@current_station = @route.stations[0]
		@current_station.add_train(self)
	end

	def add_wagon
		@wagons_count += 1 if @speed == 0
	end

	def delete_wagon
		if @speed == 0
			@wagons_count -= 1
		end
	end

	def move_to_next_station
		@current_station.trains.delete(self)
		if @current_station == @route.stations.last
			puts "Поезд достиг конечной станции"
		else
			@current_station = next_station
			@current_station.trains << self
		end
	end

	def move
		@speed = 80
	end

	def stop
		@speed = 0
	end

	def next_station
		if @route.stations.index(@current_station) == @route.stations.last
			puts "Поезд достиг конечной станции"
			nil
		else
			@route.stations[@route.stations.index(@current_station)+1]
		end
	end

	def previous_station
		if @current_station == @route.stations[0]
			@route.stations[1]
		else
			@route.stations[@route.stations.index(@current_station)-1]
		end
	end
end



