# frozen_string_literal: true

# spec/final_launch_stage_handler_spec.rb

require_relative '../final_launch_stage_handler'
require_relative '../abort_state'

RSpec.describe FinalLaunchStageHandler do
  let(:mission_execution) { double('MissionExecution') }
  let(:handler) { FinalLaunchStageHandler.new }

  describe '#process' do
    context 'when user confirms the launch' do
      it 'returns true' do
        allow(handler).to receive(:gets).and_return('y')
        expect(handler.process(mission_execution)).to be true
      end
    end

    context 'when user declines the launch' do
      it 'transitions to AbortState and returns false' do
        allow(handler).to receive(:gets).and_return('n')
        expect(mission_execution).to receive(:transition_to).with(instance_of(AbortState))
        expect(handler.process(mission_execution)).to be false
      end
    end
  end
end
