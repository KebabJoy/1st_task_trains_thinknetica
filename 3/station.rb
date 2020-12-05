require_relative 'modules'

class Station
  include InstanceCounter
  attr_reader :name; :trains
  @@stations = []

  def initialize(name)
    @trains = []
    @name = name
    @@stations << self
    register_instance
  end

  def self.all
    @@stations
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

  private #A user should not be able to change trains manually
  attr_writer :trains
end

