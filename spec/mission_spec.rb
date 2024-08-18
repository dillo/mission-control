# frozen_string_literal: true

# mission_spec.rb
require 'rspec'
require_relative '../mission'
require_relative '../mission_log'
require_relative '../mission_setup'
require_relative '../random_event'
require_relative '../rocket_factory'
require_relative '../mission_execution'

RSpec.describe Mission do
  let(:log) { instance_double('MissionLog') }
  let(:setup) do
    instance_double('MissionSetup', display_default_plan: nil, set_name: nil, confirm_mission?: true,
                                    name: 'Test Mission')
  end
  let(:random_event) { instance_double('RandomEvent') }
  let(:rocket) { instance_double('Rocket') }
  let(:execution) { instance_double('MissionExecution', execute: nil) }

  before do
    allow(MissionLog).to receive(:new).and_return(log)
    allow(MissionSetup).to receive(:new).and_return(setup)
    allow(RandomEvent).to receive(:new).and_return(random_event)
    allow(RocketFactory).to receive(:build_rocket).and_return(rocket)
    allow(MissionExecution).to receive(:new).and_return(execution)
    allow(execution).to receive(:rocket).and_return(rocket)
  end

  describe '#initialize' do
    it 'initializes with default parameters' do
      mission = Mission.new
      expect(mission.log).to eq(log)
      expect(mission.rocket).to eq(rocket)
      expect(mission.elapsed_time).to eq(0)
    end

    it 'initializes with provided parameters' do
      custom_log = MissionLog.new
      custom_setup = MissionSetup.new
      custom_random_event = RandomEvent.new(12)
      custom_rocket = RocketFactory.build_rocket

      mission = Mission.new(
        log: custom_log,
        setup: custom_setup,
        random_event: custom_random_event,
        rocket: custom_rocket
      )

      expect(mission.log).to eq(custom_log)
      expect(mission.rocket).to eq(custom_rocket)
      expect(mission.elapsed_time).to eq(0)
    end
  end

  describe '#run' do
    it 'runs the mission setup and execution' do
      mission = Mission.new
      expect(setup).to receive(:display_default_plan)
      expect(setup).to receive(:set_name)
      expect(setup).to receive(:confirm_mission?).and_return(true)
      expect(execution).to receive(:execute)

      mission.run

      expect(mission.name).to eq('Test Mission')
    end

    it 'does not execute the mission if not confirmed' do
      allow(setup).to receive(:confirm_mission?).and_return(false)
      mission = Mission.new
      expect(setup).to receive(:display_default_plan)
      expect(setup).to receive(:set_name)
      expect(execution).not_to receive(:execute)

      mission.run

      expect(mission.name).to be_nil
    end
  end
end
