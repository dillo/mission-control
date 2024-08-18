# frozen_string_literal: true

require_relative 'stage_handler'
require_relative 'manual_abort_strategy'
require_relative 'random_abort_strategy'

# The AfterburnerStageHandler class handles the afterburner stage of a mission.
# It inherits from the StageHandler class and implements the process method.
class AfterburnerStageHandler < StageHandler
  # Processes the mission execution for the afterburner stage.
  # Prompts the user to engage the afterburner and sets the appropriate abort strategy based on user input and random events.
  #
  # @param mission_execution [Object] the mission execution object that contains details about the mission
  # @return [Boolean] true if the afterburner is engaged and the mission continues, false if the mission is aborted
  def process(mission_execution)
    puts 'Engage afterburner? (Y/n)'
    if gets.chomp.downcase == 'y'
      puts 'Afterburner engaged!'

      # Set random abort strategy
      if mission_execution.random_event.should_abort?
        mission_execution.abort_strategy = RandomAbortStrategy.new
        mission_execution.handle_abort
        return false
      end
      true
    else
      # Set manual abort strategy
      mission_execution.abort_strategy = ManualAbortStrategy.new
      mission_execution.handle_abort
      false
    end
  end
end
