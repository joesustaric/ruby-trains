module RubyTrains
  module TripCalculators
    # Class Documentation Comment
    # Need to include a good example of a class documentation.
    class NumberOfRoutesDistance
      def self.calculate(network, trip, max_distance)
        return if network.nil?
        return if trip.empty?
        return if max_distance.nil?
        1
      end

      public_class_method :calculate
    end
  end
end
