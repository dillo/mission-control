# frozen_string_literal: true

require_relative 'normal_state'
require_relative 'abort_state'
require_relative 'explode_state'
require_relative 'afterburner_stage_handler'
require_relative 'release_structure_stage_handler'
require_relative 'cross_check_stage_handler'
require_relative 'final_launch_stage_handler'
require_relative 'random_event'

# The MissionExecution class is responsible for managing the execution of a mission.
# It handles the different stages of the mission, transitions between states, and logs the mission summary.
class MissionExecution
  attr_accessor :abort_count, :explosion_count, :current_state, :abort_strategy
  attr_reader :stages, :rocket, :log, :elapsed_time, :random_event

  # Initializes a new instance of the MissionExecution class.
  #
  # @param stages [Array<StageHandler>] an array of stage handlers for the mission.
  # @param rocket [Rocket] the rocket object associated with the mission.
  # @param log [MissionLog] the log object for logging mission details.
  # @param random_event [RandomEvent] the random event generator for the mission. Defaults to a new RandomEvent with a seed of 12.
  def initialize(stages:, rocket:, log:, random_event: RandomEvent.new(12))
    @stages = stages
    @rocket = rocket
    @log = log
    @elapsed_time = 0
    @random_event = random_event
    @current_state = NormalState.new
    @abort_count = 0 # Track aborts
    @explosion_count = 0 # Track explosions
    @abort_strategy = nil
  end

  # Executes the mission by processing each stage in the chain and handling state transitions.
  #
  # This method sets up the stages chain, processes each stage, checks for mission explosion conditions,
  # and either proceeds with the rocket launch, handles the explosion, or aborts the mission based on the current state.
  #
  # @return [void, nil] returns nil if the mission is aborted.
  def execute
    setup_stages_chain
    @stages_chain.handle(self)

    # Check if the mission should explode after all stages have been handled
    transition_to(ExplodeState.new) if @current_state.is_a?(NormalState) && @random_event.should_explode?

    case @current_state
    when NormalState
      launch_rocket
      @log.print_mission_summary(self)
    when ExplodeState
      explode_mission
    when AbortState
      nil
    end
  end

  # Handles the abort process for the mission using the abort strategy.
  # This method delegates the abort handling to the abort strategy, if one is defined.
  #
  # @return [void]
  def handle_abort
    abort_strategy&.handle_abort(self)
  end

  # Retries the mission from the first stage.
  # This method transitions the mission to the NormalState and restarts the execution from the first stage.
  #
  # @return [void]
  def retry_from_stage_one
    transition_to(NormalState.new)
    execute # Restart from Stage 1
  end

  # Transitions the mission to a new state.
  # This method updates the current state of the mission to the provided state.
  #
  # @param state [Object] the new state to transition to.
  # @return [void]
  def transition_to(state)
    @current_state = state
  end

  # Launches the rocket and logs the mission status.
  # This method initiates the rocket launch and updates the elapsed time during the launch.
  # It also logs the mission status at each step of the launch process.
  #
  # @return [void]
  def launch_rocket
    @rocket.launch do |rocket, elapsed_time|
      @elapsed_time = elapsed_time
      @log.print_mission_status(rocket, elapsed_time) # Ensure the status is printed here
    end
  end

  # Aborts the mission and logs the mission summary.
  # This method increments the abort count, resets the elapsed time, and resets the rocket's distance traveled.
  # It also prints a message indicating that the mission was aborted and logs the mission summary.
  #
  # @return [void]
  def abort_mission
    @abort_count += 1
    @elapsed_time = 0
    @rocket.reset_distance_traveled
    puts 'Mission aborted!'
    @log.print_mission_summary(self)
  end

  # Handles the explosion of the mission and logs the mission summary.
  # This method increments the explosion count, sets the elapsed time and distance traveled based on a random event,
  # and prints a message indicating that the mission exploded. It also logs the mission summary.
  #
  # @return [void]
  def explode_mission
    @explosion_count += 1
    @elapsed_time, @rocket.distance_traveled = @random_event.random_distance_and_time(@rocket)
    puts 'Mission exploded!'
    @log.print_mission_summary(self)
  end

  private

  # Sets up the chain of responsibility for the mission stages.
  #
  # This method initializes the stage handlers for the mission and links them together in a chain of responsibility.
  # The chain starts with the afterburner stage and proceeds through the release structure, cross-check, and final launch stages.
  #
  # @return [void]
  def setup_stages_chain
    afterburner = AfterburnerStageHandler.new
    release_structure = ReleaseStructureStageHandler.new
    cross_check = CrossCheckStageHandler.new
    final_launch = FinalLaunchStageHandler.new

    afterburner.next_handler = release_structure
    release_structure.next_handler = cross_check
    cross_check.next_handler = final_launch

    @stages_chain = afterburner
  end
end
