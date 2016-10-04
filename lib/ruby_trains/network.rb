module RubyTrains
  # Network
  # A network object contains a hash of unique stations that are in a network.
  # Each station knows it's connections.
  # It's main function is to parse the input create the stations.
  class Network
    attr_reader :stations

    def initialize(connections = [])
      @stations = {}
      generate_network connections unless connections.empty?
    end

    def generate_network(connections)
      connections.each do |connection|
        conn_hash = make_connection_hash connection
        add_connection_to_from_station conn_hash
        add_stations conn_hash
      end
    end

    def make_connection_hash(conn)
      {
        from: get_from_station(conn),
        to: get_to_station(conn),
        distance: get_connection_distance(conn)
      }
    end

    def add_stations(conn_hash)
      @stations[conn_hash[:from].name] = conn_hash[:from]
      @stations[conn_hash[:to].name] = conn_hash[:to]
    end

    def add_connection_to_from_station(conn_hash)
      conn_hash[:from].add_connection create_connection(conn_hash)
    end

    def create_connection(conenction_hash)
      Connection.new conenction_hash[:to], conenction_hash[:distance]
    end

    def get_from_station(connection)
      return Station.new(connection[0]) unless station_exists?(connection[0])
      @stations[connection[0]]
    end

    def get_to_station(connection)
      return Station.new(connection[1]) unless station_exists?(connection[1])
      @stations[connection[1]]
    end

    def get_connection_distance(connection)
      connection[2..-1].to_i
    end

    def station_exists?(station_name)
      @stations.key? station_name
    end

    private :add_stations, :make_connection_hash, :generate_network
    private :create_connection, :get_from_station, :get_to_station
    private :get_connection_distance, :add_connection_to_from_station
    private :station_exists?
  end
end
