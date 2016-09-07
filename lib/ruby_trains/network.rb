# require 'station'

module RubyTrains
  # Class Documentation Comment
  # Need to include a good example of a class documentation.
  class Network
    attr_reader :stations

    def initialize(connections = '')
      @stations = {}

      generate_network connections
    end

    def generate_network(connections)
      # return unless connections =~ /^\w{2}\d+$/
      # from_station = Station.new connections[0]
      # to_station = Station.new connections[1]
      #
      # conn = Connection.new to_station, connections[2..-1]
    end
  end
end
