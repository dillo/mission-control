# frozen_string_literal: true

# The Rocket class represents a rocket with various attributes and methods to simulate its journey.
class Rocket
  attr_reader :destination_distance, :fuel_capacity, :burn_rate, :payload_capacity, :average_speed
  attr_accessor :distance_traveled, :fuel_remaining, :total_fuel_burned

  # Initializes a new Rocket instance.
  #
  # @param destination_distance [Integer] the distance to the destination
  # @param fuel_capacity [Integer] the total fuel capacity
  # @param burn_rate [Integer] the rate at which fuel is burned per minute
  # @param payload_capacity [Integer] the payload capacity
  # @param average_speed [Integer] the average speed of the rocket
  def initialize(destination_distance:, fuel_capacity:, burn_rate:, payload_capacity:, average_speed:)
    @destination_distance = destination_distance
    @fuel_capacity = fuel_capacity
    @burn_rate = burn_rate
    @payload_capacity = payload_capacity
    @average_speed = average_speed
    @distance_traveled = 0
    @fuel_remaining = fuel_capacity
    @total_fuel_burned = 0
  end

  # Resets the distance traveled to zero.
  #
  # @return [void]
  def reset_distance_traveled
    @distance_traveled = 0
  end

  # Burns fuel for a given number of minutes.
  #
  # @param minutes [Integer] the number of minutes to burn fuel
  # @return [void]
  # def burn_fuel(minutes)
  #   fuel_to_burn = @burn_rate * minutes
  #   @fuel_remaining -= fuel_to_burn
  #   @total_fuel_burned += fuel_to_burn
  #   @fuel_remaining = 0 if @fuel_remaining.negative?
  # end
  def burn_fuel(minutes)
    fuel_to_burn = [@burn_rate * minutes, @fuel_remaining].min
    @fuel_remaining -= fuel_to_burn
    @total_fuel_burned += fuel_to_burn
  end

  # Updates the distance traveled based on the time elapsed.
  #
  # @param minutes [Integer] the number of minutes elapsed
  # @return [void]
  def update_distance(minutes)
    distance_increment = (@average_speed / 60.0) * minutes
    @distance_traveled += distance_increment

    return unless @distance_traveled > @destination_distance

    @distance_traveled = @destination_distance
  end

  # Launches the rocket and simulates its journey until it runs out of fuel or reaches its destination.
  #
  # @yield [rocket, elapsed_time] Yields the rocket instance and the elapsed time to the block, if given
  # @yieldparam rocket [Rocket] the current instance of the rocket
  # @yieldparam elapsed_time [Integer] the elapsed time in seconds
  # @return [void]
  def launch
    elapsed_time = 0
    interval = 60 # seconds

    while @fuel_remaining.positive? && @distance_traveled < @destination_distance
      burn_fuel(interval / 60.0)
      update_distance(interval / 60.0)
      elapsed_time += interval

      yield self, elapsed_time if block_given?

      break if @fuel_remaining <= 0
    end
  end

  # Returns the current status of the rocket.
  #
  # This method provides a hash containing the current fuel burn rate, speed,
  # distance traveled, and fuel remaining for the rocket.
  #
  # @return [Hash] a hash with the following keys:
  #   - :fuel_burn_rate [Float] the current fuel burn rate of the rocket
  #   - :speed [Float] the current average speed of the rocket
  #   - :distance_traveled [Float] the total distance traveled by the rocket, rounded to two decimal places
  #   - :fuel_remaining [Float] the remaining fuel of the rocket
  def current_status
    {
      fuel_burn_rate: @burn_rate,
      speed: @average_speed,
      distance_traveled: @distance_traveled.round(2),
      fuel_remaining: @fuel_remaining
    }
  end
end
