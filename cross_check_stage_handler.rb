# frozen_string_literal: true

require_relative 'stage_handler'

# The CrossCheckStageHandler class handles the cross-check stage of a mission.
# It inherits from the StageHandler class and implements the process method.
class CrossCheckStageHandler < StageHandler
  # Processes the mission execution for the cross-check stage.
  # Prompts the user to perform cross-checks and transitions to the AbortState if the user declines.
  #
  # @param mission_execution [Object] the mission execution object that contains details about the mission
  # @return [Boolean] true if the cross-checks are performed and the mission continues, false if the mission is aborted
  def process(mission_execution)
    puts 'Perform cross-checks? (Y/n)'

    if gets.chomp.downcase == 'y'
      puts 'Cross-checks performed!'
      true
    else
      mission_execution.transition_to(AbortState.new)
      false
    end
  end
end
