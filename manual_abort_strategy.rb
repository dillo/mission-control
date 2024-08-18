# frozen_string_literal: true

require_relative 'mission_abort_strategy'

# The ManualAbortStrategy class defines the behavior for manually aborting a mission.
# It inherits from the MissionAbortStrategy class and implements the handle_abort method.
class ManualAbortStrategy < MissionAbortStrategy
  # Handles the abort process for a mission.
  # Increments the abort count and prompts the user to retry from stage one or print the mission summary.
  #
  # @param mission_execution [Object] the mission execution object that contains details about the mission
  def handle_abort(mission_execution)
    puts 'Mission aborted by user!'
    mission_execution.abort_count += 1
    mission_execution.transition_to(AbortState.new)

    puts 'Retry from stage one? (Y/n)'
    if gets.chomp.downcase == 'y'
      mission_execution.retry_from_stage_one
    else
      mission_execution.log.print_mission_summary(mission_execution)

      nil
    end
  end
end
