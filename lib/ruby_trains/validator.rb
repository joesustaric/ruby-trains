module RubyTrains
  # Validator
  # This class just deals with validating the user input
  class Validator
    ERROR = 'input error'.freeze
    # will match two letters followed by numbers
    # eg AB1 XY83 not FooB1 ABar123
    CONNECTION_REGEX = /^\w{2}\d+(\s{1}\w{2}\d+)*/

    # Matches A-B , AA-B, Foo-Bar
    TRIP_REGEX = /^([A-Za-z]+)-([A-Za-z]+)$/

    # Matches A-B , AA-B-CC, Foo-Bar-A , X-Y-Z-B
    ROUTE_REGEX = /^([A-Za-z]+)(-[A-Za-z]+)*(-[A-Za-z]+)$/

    def self.parse_network(input)
      result = CONNECTION_REGEX.match(input.strip).to_s.split(' ')
      raise ERROR if result.empty?
      result
    end

    def self.parse_trip(input)
      result = TRIP_REGEX.match(input.strip).to_s.split('-')
      raise ERROR if result.empty?
      result
    end

    def self.parse_route(input)
      result = ROUTE_REGEX.match(input.strip).to_s.split('-')
      raise ERROR if result.empty?
      result
    end
  end
end
