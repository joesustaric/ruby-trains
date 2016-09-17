module RubyTrains
  # Station
  # Represents a train station.
  # It includes a name and a has of connections to other stations,
  # keyed by name.
  class Station
    attr_reader :name, :connections

    def initialize(name)
      @name = name
      @connections = {}
    end

    def add_connection(connection)
      @connections[connection.station.name] = connection
    end
  end
end
