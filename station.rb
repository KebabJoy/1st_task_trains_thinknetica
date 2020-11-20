class Station
	attr_reader :name
	attr_accessor :trains

	def initialize(name)
		@trains = []
		@name = name
	end

	def trains_count
		@trains.length
	end

	def add_train(train)
		@trains << train
	end

	def trains_by_type(type)
		@trains.select {|train| train.type == type }
	end

	def depart_train(train)
		if @trains.include?(train)
			@trains.delete(train)
		else
			puts "Поезда нет на этой станции"
		end
	end
end

