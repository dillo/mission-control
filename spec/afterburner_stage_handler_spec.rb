# frozen_string_literal: true

# spec/afterburner_stage_handler_spec.rb
require 'rspec'
require_relative '../afterburner_stage_handler'
require_relative '../manual_abort_strategy'
require_relative '../random_abort_strategy'

RSpec.describe AfterburnerStageHandler do
  let(:mission_execution) { double('MissionExecution') }
  let(:random_event) { double('RandomEvent') }
  let(:afterburner_stage_handler) { AfterburnerStageHandler.new }

  before do
    allow(mission_execution).to receive(:random_event).and_return(random_event)
    allow(mission_execution).to receive(:abort_strategy=)
    allow(mission_execution).to receive(:handle_abort)
  end

  context 'when user engages the afterburner' do
    before do
      allow(afterburner_stage_handler).to receive(:gets).and_return('y')
    end

    it 'continues the mission if no random event aborts' do
      allow(random_event).to receive(:should_abort?).and_return(false)
      expect(afterburner_stage_handler.process(mission_execution)).to be true
    end

    it 'aborts the mission if a random event occurs' do
      allow(random_event).to receive(:should_abort?).and_return(true)
      expect(mission_execution).to receive(:abort_strategy=).with(instance_of(RandomAbortStrategy))
      expect(mission_execution).to receive(:handle_abort)
      expect(afterburner_stage_handler.process(mission_execution)).to be false
    end
  end

  context 'when user does not engage the afterburner' do
    before do
      allow(afterburner_stage_handler).to receive(:gets).and_return('n')
    end

    it 'aborts the mission manually' do
      expect(mission_execution).to receive(:abort_strategy=).with(instance_of(ManualAbortStrategy))
      expect(mission_execution).to receive(:handle_abort)
      expect(afterburner_stage_handler.process(mission_execution)).to be false
    end
  end
end
