# frozen_string_literal: true

require_relative 'stage_handler'

# The ReleaseStructureStageHandler class handles the release of support structures during a mission.
# It inherits from the StageHandler class and implements the process method.
class ReleaseStructureStageHandler < StageHandler
  # Processes the mission execution for the release structure stage.
  # Prompts the user to release the support structures and transitions to the AbortState if the user declines.
  #
  # @param mission_execution [Object] the mission execution object that contains details about the mission
  # @return [Boolean] true if the support structures are released and the mission continues, false if the mission is aborted
  def process(mission_execution)
    puts 'Release support structures? (Y/n)'

    if gets.chomp.downcase == 'y'
      puts 'Support structures released!'
      true
    else
      mission_execution.transition_to(AbortState.new)
      false
    end
  end
end
