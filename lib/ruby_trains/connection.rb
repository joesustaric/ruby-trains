module RubyTrains
  # Class Documentation Comment
  # Need to include a good example of a class documentation.
  class Connection
    attr_reader :station, :distance

    def initialize(station, distance)
      @station = station
      @distance = distance
    end
  end
end
