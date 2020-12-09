require_relative 'modules'

class Train
  include InstanceCounter
  include Company
  attr_reader :type; :number; :route; :current_station; :speed; :wagons
  @@trains = {}
  NUM_FORMAT = /[\w\d]{3}-?[\w\d]{0,2}/


  def initialize(num)
    @number = num
    @speed = 0
    @wagons = []
    validate!
    @@trains[num] = self
    register_instance
  end

  def self.find(id)
    @@trains[id]
  end

  def set_route(route)
    @route = route
    @current_station = @route.stations[0]
    @current_station.add_train(self)
  end

  def add_wagon(wagon)
    if @type == wagon.type
      @wagons << wagon
    end
  end

  def delete_wagon
    @wagons.pop
  end

  def move_to_next_station
    return unless next_station
    @current_station.depart_train(self)
    @current_station = next_station
    @current_station.add_train(self)
  end

  def move_to_previous_station
    return unless previous_station
    @current_station.depart_train(self)
    @current_station = previous_station
    @current_station.add_train(self)
  end

  def move
    @speed = 80
  end

  def stop
    @speed = 0
  end

  def next_station
    if @route.stations.index(@current_station) != @route.stations.last
      @route.stations[@route.stations.index(@current_station)+1]
    end
  end

  def previous_station
    if @current_station != @route.stations[0]
      @route.stations[@route.stations.index(@current_station)-1]
    end
  end

  def valid?
    validate!
    true
  rescue
    false
  end

  protected #A user has method valid? to validate object

  def validate!
    raise 'nil' if @number.nil?
    raise "format_error" if @number !~ NUM_FORMAT
  end

  private #A user should not be able to change speed and wagons manually
  attr_writer :speed; :wagons

end


