# require 'station'

module RubyTrains
  # Class Documentation Comment
  # Need to include a good example of a class documentation.
  class Network
    attr_reader :stations

    def initialize(connections = '')
      @stations = {}

      generate_network connections unless connections == ''
    end

    def generate_network(connections_input)
      # return unless connections =~ /^\w{2}\d+$/
      connections = connections_input.split(' ')
      connections.each do |connection|
        conn_hash = make_connection_hash connection

        conn = Connection.new conn_hash[:to], conn_hash[:distance]
        conn_hash[:from].add_connection conn

        @stations[conn_hash[:from].name] = conn_hash[:from]
        @stations[conn_hash[:to].name] = conn_hash[:to]
      end
    end

    def make_connection_hash(connection)
      {
        from: Station.new(connection[0]),
        to: Station.new(connection[1]),
        distance: connection[2..-1]
      }
    end
  end
end
