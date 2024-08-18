# frozen_string_literal: true

require_relative 'mission_abort_strategy'

# The RandomAbortStrategy class defines the behavior for aborting a mission due to random events.
# It inherits from the MissionAbortStrategy class and implements the handle_abort method.
class RandomAbortStrategy < MissionAbortStrategy
  # Handles the abort process for a mission due to a random event.
  # Increments the abort count and prints the mission summary.
  #
  # @param mission_execution [Object] the mission execution object that contains details about the mission
  def handle_abort(mission_execution)
    puts 'Mission aborted due to a random event!'
    mission_execution.abort_count += 1
    mission_execution.transition_to(AbortState.new)
    mission_execution.log.print_mission_summary(mission_execution)

    nil
  end
end
