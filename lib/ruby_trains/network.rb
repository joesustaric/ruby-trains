
module RubyTrains
  # Class Documentation Comment
  # Need to include a good example of a class documentation.
  class Network
    attr_reader :stations

    def initialize(connections = '')
      @stations = {}
      generate_network connections unless connections.empty?
    end

    def generate_network(connections_input)
      # return unless connections =~ /^\w{2}\d+$/
      connections = connections_input.split(' ')

      connections.each do |connection|
        conn_hash = make_connection_hash connection
        conn_hash[:from].add_connection create_connection(conn_hash)
        add_stations conn_hash
      end
    end

    def make_connection_hash(connection)
      {
        from: get_from_station(connection),
        to: get_to_station(connection),
        distance: get_connection_distance(connection)
      }
    end

    def add_stations(connection_hash)
      @stations[connection_hash[:from].name] = connection_hash[:from]
      @stations[connection_hash[:to].name] = connection_hash[:to]
    end

    def create_connection(conenction_hash)
      Connection.new conenction_hash[:to], conenction_hash[:distance]
    end

    def get_from_station(connection)
      return Station.new(connection[0]) unless @station[connection[0]].key?(connection[0])
      @station[onnection[0]]
    end

    def get_to_station(connection)
      return Station.new(connection[1]) unless @station[connection[1]].key?(connection[1])
      @station[onnection[1]]
    end

    def get_connection_distance(connection)
      connection[2..-1]
    end

    private :add_stations, :make_connection_hash, :generate_network
    private :create_connection, :get_from_station, :get_to_station
    private :get_connection_distance
  end
end
