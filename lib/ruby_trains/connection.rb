module RubyTrains
  # Connection
  # It's just a station with a distance value which represents the distance from
  # the station to the connecting station.
  class Connection
    attr_reader :station, :distance

    def initialize(station, distance)
      @station = station
      @distance = distance
    end
  end
end
