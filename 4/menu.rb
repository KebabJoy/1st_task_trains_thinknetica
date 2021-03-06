require 'route.rb'
require 'station.rb'
require 'train.rb'


class Menu
  attr_reader :stations; :route; :trains
  def initialize
    print_menu
    choose_method
    @stations = {}
    @route = {}
    @trains = {}
  end

  def print_menu
    puts "Choose your option:\n"
    "1) Create station\n"
    "2) Create train\n"
    "3) Create route"
    "4) Add a station to your route"
    "5) Delete a station from your route"
    "6) Assign the route of the train"
    "7) Add a wagon to your train"
    "8) Delete a wagon from your train"
    "9) Move the train to its next station"
    "10) Move the train to its previous station"
    "11) Show stations list"
    "12) Show trains list at a station"
  end

  private #A user should not be able to use these methods manually, so I made them private
  attr_writer :stations; :route; :trains

  def choose_method
    command = gets.chomp

    until command == ''
      case command
      when '1'
        create_station
      when '2'
        create_train
      when '3'
        create_route
      when '4'
        add_station_to_route
      when '5'
        delete_station_from_route
      when '6'
        set_route_to_train
      when '7'
        add_wagon
      when '8'
        delete_wagon
      when '9'
        move_train_forward
      when '10'
        move_train_back
      when '11'
        show_stations
      when '12'
        show_trains
      else
        puts "Unknown command. Type numbers from 1 to 12"
      end
      print_menu
      choose_method
    end
  end

  def create_station
    puts "Enter station's name:"
    name = gets.chomp
    station = Station.new(name)
    @stations[name] = station
  end

  def create_train
    puts "Entre train's number and type"
    num = gets.chomp
    type = gets.chomp
    if type == "Cargo"
      train = CargoTrain.new(num)
    else
      train = PassengerTrain.new(num)
    end
    @trains[num] = train
    puts "Train number #{num} has been created"
  rescue RuntimeError => e
      puts e.message
    retry
  end

  def create_route
    if @stations.length > 2
      puts "Enter first and last stations' names:"
      name_first = gets.chomp
      name_last = gets.chomp
      @route = Route.new(@stations[name_first],@stations[name_last])
    else
      puts "You need #{2-@stations.length} more stations"
    end
  end

  def add_station_to_route
    station_name = gets.chomp
    if @stations[station_name]
      @route.add_station(@stations[station_name])
    else
      puts "Wrong station"
    end
  end

  def delete_station_from_route
    station_name = gets.chomp
    if @stations[station_name]
      @route.delete_station(@stations[station_name])
    else
      puts "Wrong station"
    end
  end

  def set_route_to_train
    puts "Enter train's number:"
    num = gets.chomp
    @trains[num].set_route(@route)
  end

  def add_wagon
    puts "Enter train's number and company:"
    num = gets.chomp
    comp = gets.chomp
    wagon = Wagon.new(@trains[num].type,comp)
    @trains[num].add_wagon(wagon)
  end

  def delete_wagon
    puts "Enter train's number:"
    num = gets.chomp
    @trains[num].delete_wagon
  end

  def move_train_forward
    puts "Enter train's number:"
    num = gets.chomp
    @trains[num].move_to_next_station
  end

  def move_train_back
    puts "Enter train's number:"
    num = gets.chomp
    @trains[num].move_to_previous_station
  end

  def show_stations
    @route.stations
  end

  def show_trains
    puts "Enter station's name:"
    name = gets.chomp
    @stations[name]
  end

end
