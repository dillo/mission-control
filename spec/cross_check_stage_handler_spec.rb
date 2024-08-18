# frozen_string_literal: true

# spec/cross_check_stage_handler_spec.rb
require_relative '../cross_check_stage_handler'
require_relative '../abort_state'

RSpec.describe CrossCheckStageHandler do
  let(:cross_check_stage_handler) { CrossCheckStageHandler.new }
  let(:mission_execution) { instance_double('MissionExecution') }

  describe '#process' do
    context 'when user inputs y' do
      it 'returns true and prints "Cross-checks performed!"' do
        allow(cross_check_stage_handler).to receive(:gets).and_return('y')
        expect { cross_check_stage_handler.process(mission_execution) }.to output(/Cross-checks performed!/).to_stdout
        expect(cross_check_stage_handler.process(mission_execution)).to be true
      end
    end

    context 'when user inputs n' do
      it 'transitions to AbortState and returns false' do
        allow(cross_check_stage_handler).to receive(:gets).and_return('n')
        expect(mission_execution).to receive(:transition_to).with(instance_of(AbortState))
        expect(cross_check_stage_handler.process(mission_execution)).to be false
      end
    end
  end
end
