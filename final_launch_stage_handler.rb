# frozen_string_literal: true

require_relative 'stage_handler'

# The FinalLaunchStageHandler class handles the final launch stage of a mission.
# It inherits from the StageHandler class and implements the process method.
class FinalLaunchStageHandler < StageHandler
  # Processes the mission execution for the final launch stage.
  # Prompts the user to confirm the launch and transitions to the AbortState if the user declines.
  #
  # @param mission_execution [Object] the mission execution object that contains details about the mission
  # @return [Boolean] true if the launch is confirmed and the mission continues, false if the mission is aborted
  def process(mission_execution)
    puts 'Launch? (Y/n)'

    if gets.chomp.downcase == 'y'
      true
    else
      mission_execution.transition_to(AbortState.new)
      false
    end
  end
end
