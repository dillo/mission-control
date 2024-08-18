# frozen_string_literal: true

require 'forwardable'

require_relative 'mission_setup'
require_relative 'rocket_factory'
require_relative 'mission_execution'
require_relative 'mission_log'
require_relative 'random_event'

# Mission class handles the setup and execution of a mission.
# It utilizes the Chain of Responsibility and State Patterns for mission execution.
class Mission
  extend Forwardable
  attr_reader :name, :log, :elapsed_time, :rocket

  def_delegators :@execution, :rocket, :abort_count, :explosion_count

  # Initializes a new Mission instance.
  #
  # @param log [MissionLog] the log to record mission events (default: MissionLog.new)
  # @param setup [MissionSetup] the setup for the mission (default: MissionSetup.new)
  # @param random_event [RandomEvent] the random event generator for the mission (default: RandomEvent.new(12))
  # @param rocket [Rocket] the rocket to be used in the mission (default: RocketFactory.build_rocket)
  def initialize(
    log: MissionLog.new,
    setup: MissionSetup.new,
    random_event: RandomEvent.new(12),
    rocket: RocketFactory.build_rocket
  )
    @log = log
    @setup = setup
    @random_event = random_event
    @rocket = rocket
    @elapsed_time = 0

    # Set up mission execution with the Chain of Responsibility and State Patterns
    @execution = MissionExecution.new(
      stages: default_stages,
      rocket: @rocket,
      log: @log,
      random_event: @random_event
    )
  end

  # Runs the mission setup and execution.
  #
  # This method performs the following steps:
  # 1. Displays the default mission plan.
  # 2. Sets the mission name.
  # 3. Confirms the mission with the user.
  # 4. If the mission is confirmed, it sets the mission name and executes the mission.
  #
  # @return [void]
  def run
    @setup.display_default_plan
    @setup.set_name

    return unless @setup.confirm_mission?

    @name = @setup.name
    @execution.execute
  end

  private

  # Sets up the default stages for the mission.
  #
  # This method initializes and returns an array of stage handlers that represent
  # the different stages of the mission. Each stage handler is responsible for a
  # specific part of the mission execution process.
  #
  # @return [Array<StageHandler>] an array of stage handlers for the mission
  def default_stages
    # Set up the chain of stages
    [
      AfterburnerStageHandler.new,
      ReleaseStructureStageHandler.new,
      CrossCheckStageHandler.new,
      FinalLaunchStageHandler.new
    ]
  end
end
