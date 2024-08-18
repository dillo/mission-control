# frozen_string_literal: true

require 'rspec'
require_relative '../mission_execution'
require_relative '../rocket'
require_relative '../mission_log'
require_relative '../normal_state'
require_relative '../abort_state'
require_relative '../explode_state'
require_relative '../random_event'
require_relative '../afterburner_stage_handler'
require_relative '../release_structure_stage_handler'
require_relative '../cross_check_stage_handler'
require_relative '../final_launch_stage_handler'

RSpec.describe MissionExecution do
  let(:rocket) do
    Rocket.new(destination_distance: 500, fuel_capacity: 1000, burn_rate: 10, payload_capacity: 5000,
               average_speed: 100)
  end
  let(:log) { instance_double(MissionLog) }
  let(:random_event) { instance_double(RandomEvent) }
  let(:stages) do
    [AfterburnerStageHandler.new, ReleaseStructureStageHandler.new, CrossCheckStageHandler.new,
     FinalLaunchStageHandler.new]
  end
  let(:mission_execution) { described_class.new(stages:, rocket:, log:, random_event:) }

  before do
    allow(mission_execution).to receive(:setup_stages_chain).and_call_original
    allow(log).to receive(:print_mission_summary)
    allow(random_event).to receive(:should_explode?).and_return(false)
    allow(random_event).to receive(:should_abort?).and_return(false)
    allow_any_instance_of(AfterburnerStageHandler).to receive(:gets).and_return('y')
    allow_any_instance_of(ReleaseStructureStageHandler).to receive(:gets).and_return('y')
    allow_any_instance_of(CrossCheckStageHandler).to receive(:gets).and_return('y')
    allow_any_instance_of(FinalLaunchStageHandler).to receive(:gets).and_return('y') # Add this line
  end

  describe '#execute' do
    context 'when the mission is in NormalState and does not explode' do
      it 'sets up the stages chain and launches the rocket' do
        expect(mission_execution).to receive(:setup_stages_chain)
        expect(mission_execution).to receive(:launch_rocket)
        expect(log).to receive(:print_mission_summary)

        mission_execution.execute
      end
    end

    context 'when the mission is in NormalState and explodes' do
      before do
        allow(random_event).to receive(:should_explode?).and_return(true)
      end

      it 'sets up the stages chain and triggers explosion' do
        expect(mission_execution).to receive(:setup_stages_chain)
        expect(mission_execution).not_to receive(:launch_rocket)
        expect(mission_execution).to receive(:explode_mission)

        mission_execution.execute
      end
    end

    context 'when the mission is in AbortState' do
      before do
        mission_execution.transition_to(AbortState.new)
      end

      it 'does not launch or explode the rocket' do
        expect(mission_execution).not_to receive(:launch_rocket)
        expect(mission_execution).not_to receive(:explode_mission)
        expect(log).not_to receive(:print_mission_summary)

        mission_execution.execute
      end
    end
  end
end
