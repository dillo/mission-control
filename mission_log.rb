# frozen_string_literal: true

require_relative 'loggable'

# The MissionLog class is responsible for logging and printing the status and summary of missions.
# It includes the Loggable module for logging capabilities.
class MissionLog
  include Loggable

  # Prints the current status of the mission.
  #
  # @param rocket [Rocket] the rocket object containing the current mission details.
  # @param elapsed_time [Float] the elapsed time since the mission started in seconds.
  #
  # @return [void]
  def print_mission_status(rocket, elapsed_time)
    remaining_distance = rocket.destination_distance - rocket.distance_traveled
    time_to_destination = remaining_distance.positive? ? remaining_distance / (rocket.average_speed / 3600.0) : 0

    status = rocket.current_status
    puts 'Mission status:'
    puts "  Current fuel burn rate: #{status[:fuel_burn_rate]} liters/min"
    puts "  Current speed: #{status[:speed]} km/h"
    puts "  Current distance traveled: #{status[:distance_traveled]} km"
    puts "  Elapsed time: #{format_time(elapsed_time)}"
    puts "  Time to destination: #{format_time(time_to_destination * 3600)}"
    puts
  end

  # Prints the summary of the mission.
  #
  # @param mission [Mission] the mission object containing the details of the mission.
  #
  # @return [void]
  def print_mission_summary(mission)
    rocket = mission.rocket
    total_distance_traveled = rocket.distance_traveled
    total_fuel_burned = rocket.total_fuel_burned
    aborts = mission.abort_count # Delegated from Mission to MissionExecution
    explosions = mission.explosion_count # Delegated from Mission to MissionExecution

    puts 'Mission summary:'
    puts "  Total distance traveled: #{total_distance_traveled.round(2)} km"
    puts "  Number of abort and retries: #{aborts}/#{aborts}" # Assuming retry count is same as aborts
    puts "  Number of explosions: #{explosions}"
    puts "  Total fuel burned: #{total_fuel_burned.round(2)} liters"
    puts "  Flight time: #{format_time(mission.elapsed_time)}"
    puts
  end

  # Prints the status of all missions.
  #
  # @param missions [Array<Mission>] an array of mission objects.
  #
  # @return [void]
  def print_all_missions_status(missions)
    total_distance_traveled = 0
    total_fuel_burned = 0
    total_flight_time = 0
    total_aborts = 0
    total_explosions = 0

    missions.each do |mission|
      total_distance_traveled += mission.rocket.distance_traveled
      total_fuel_burned += mission.rocket.total_fuel_burned
      total_flight_time += mission.elapsed_time || 0
      total_aborts += mission.abort_count # Delegated from Mission to MissionExecution
      total_explosions += mission.explosion_count # Delegated from Mission to MissionExecution
    end

    puts 'All missions Summary:'
    puts "  Total distance traveled: #{total_distance_traveled.round(2)} km"
    puts "  Number of aborts: #{total_aborts}"
    puts "  Number of explosions: #{total_explosions}"
    puts "  Total fuel burned: #{total_fuel_burned.round(2)} liters"
    puts "  Total flight time: #{format_time(total_flight_time)}"
    puts
  end

  private

  # Formats a given time in seconds into a string with the format "HH:MM:SS".
  #
  # @param seconds [Float] the time in seconds to be formatted.
  #
  # @return [String] the formatted time string.
  def format_time(seconds)
    mins, secs = seconds.divmod(60)
    hours, mins = mins.divmod(60)
    format('%02d:%02d:%02d', hours, mins, secs)
  end
end
