# frozen_string_literal: true

require_relative 'mission'
require_relative 'mission_log'

# The Game class represents the main control flow for running missions.
# It manages the creation, execution, and logging of missions.
class Game
  # @!attribute [r] missions
  #   @return [Array<Mission>] the list of missions that have been executed
  attr_reader :missions

  # @!attribute [r] log
  #   @return [MissionLog] the log used to record mission details
  attr_reader :log

  # Initializes a new Game instance.
  #
  # @param log [MissionLog] the log to be used for recording mission details
  def initialize(log:)
    @log = log
    @missions = []

    puts 'Welcome to Mission Control!'
  end

  # Runs the main game loop, creating and executing missions until the user decides to stop.
  def run
    loop do
      mission = create_and_execute_mission
      missions << mission if mission
      log.print_all_missions_status(missions)

      break unless play_again?
    end
  end

  private

  # Creates and executes a new mission.
  #
  # @return [Mission, nil] the created mission if it has a name, otherwise nil
  def create_and_execute_mission
    mission = Mission.new
    mission.run

    mission if mission.name
  end

  # Asks the user if they want to run another mission.
  #
  # @return [Boolean] true if the user wants to run another mission, false otherwise
  def play_again?
    puts 'Would you like to run another mission? (Y/n)'
    gets.chomp.downcase == 'y'
  end
end
