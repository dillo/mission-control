# frozen_string_literal: true

# spec/manual_abort_strategy_spec.rb

require 'rspec'
require_relative '../manual_abort_strategy'
require_relative '../mission_execution'
require_relative '../abort_state'

RSpec.describe ManualAbortStrategy do
  let(:mission_execution) { instance_double('MissionExecution', abort_count: 0, log: instance_double('Log')) }
  let(:abort_state) { instance_double('AbortState') }
  let(:strategy) { ManualAbortStrategy.new }

  before do
    allow(AbortState).to receive(:new).and_return(abort_state)
    allow(mission_execution).to receive(:transition_to)
    allow(mission_execution).to receive(:retry_from_stage_one)
    allow(mission_execution.log).to receive(:print_mission_summary)
    allow(mission_execution).to receive(:abort_count=).with(anything)
    allow(mission_execution).to receive(:abort_count).and_return(0, 1)
  end

  describe '#handle_abort' do
    context 'when user chooses to retry from stage one' do
      before do
        allow(strategy).to receive(:gets).and_return('y')
      end

      it 'increments the abort count' do
        expect { strategy.handle_abort(mission_execution) }.to change { mission_execution.abort_count }.by(1)
      end

      it 'transitions the mission execution to AbortState' do
        strategy.handle_abort(mission_execution)
        expect(mission_execution).to have_received(:transition_to).with(abort_state)
      end

      it 'retries the mission from stage one' do
        strategy.handle_abort(mission_execution)
        expect(mission_execution).to have_received(:retry_from_stage_one)
      end
    end

    context 'when user chooses not to retry from stage one' do
      before do
        allow(strategy).to receive(:gets).and_return('n')
      end

      it 'increments the abort count' do
        expect { strategy.handle_abort(mission_execution) }.to change { mission_execution.abort_count }.by(1)
      end

      it 'transitions the mission execution to AbortState' do
        strategy.handle_abort(mission_execution)
        expect(mission_execution).to have_received(:transition_to).with(abort_state)
      end

      it 'prints the mission summary' do
        strategy.handle_abort(mission_execution)
        expect(mission_execution.log).to have_received(:print_mission_summary).with(mission_execution)
      end
    end
  end
end
