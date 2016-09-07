module RubyTrains
  # Class Documentation Comment
  # Need to include a good example of a class documentation.
  class Station
    attr_reader :name, :connections

    def initialize(name)
      @name = name
      @connections = {}
    end
  end
end
