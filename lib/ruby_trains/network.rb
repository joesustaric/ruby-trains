
module RubyTrains
  # Class Documentation Comment
  # Need to include a good example of a class documentation.
  class Network
    attr_reader :stations

    CONNECTION_REGEX = /^\w{2}\d+$/
    # will match two letters followed by numbers
    # eg AB1 XY83 not FooB1 ABar123

    def initialize(connections = '')
      @stations = {}
      generate_network connections unless connections.empty?
    end

    def generate_network(connections_input)
      connections = connections_input.split(' ')

      connections.each do |connection|
        conn_hash = make_connection_hash connection
        add_connection_to_from_station conn_hash
        add_stations conn_hash
      end
    end

    def make_connection_hash(conn)
      return unless conn =~ CONNECTION_REGEX
      {
        from: get_from_station(conn),
        to: get_to_station(conn),
        distance: get_connection_distance(conn)
      }
    end

    def add_stations(conn_hash)
      return if conn_hash.nil?
      @stations[conn_hash[:from].name] = conn_hash[:from]
      @stations[conn_hash[:to].name] = conn_hash[:to]
    end

    def add_connection_to_from_station(conn_hash)
      return if conn_hash.nil?
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
