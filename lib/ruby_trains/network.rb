
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
        conn_hash[:from].add_connection create_connection(conn_hash)
        add_stations conn_hash
      end
    end

    def make_connection_hash(connection)
      {
        from: Station.new(connection[0]),
        to: Station.new(connection[1]),
        distance: connection[2..-1]
      }
    end

    def add_stations(connection_hash)
      @stations[connection_hash[:from].name] = connection_hash[:from]
      @stations[connection_hash[:to].name] = connection_hash[:to]
    end

    def create_connection(conenction_hash)
      Connection.new conenction_hash[:to], conenction_hash[:distance]
    end

    private :add_stations, :make_connection_hash, :generate_network
    private :create_connection
  end
end
