module RubyTrains
  # Validator
  # This class just deals with validating the user input
  class Validator
    # will match two letters followed by numbers
    # eg AB1 XY83 not FooB1 ABar123
    CONNECTION_REGEX = /^\w{2}\d+(\s{1}\w{2}\d+)*/

    def self.parse_network(input)
      CONNECTION_REGEX.match(input).to_s.split(' ')
    end
  end
end
