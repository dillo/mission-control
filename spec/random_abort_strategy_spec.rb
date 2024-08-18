# frozen_string_literal: true

# spec/random_abort_strategy_spec.rb
require 'rspec'
require_relative '../random_abort_strategy'
require_relative '../mission_abort_strategy'
require_relative '../abort_state'

RSpec.describe RandomAbortStrategy do
  let(:mission_execution) { double('MissionExecution', abort_count: 0, log: double('Log')) }
  let(:random_abort_strategy) { RandomAbortStrategy.new }

  before do
    allow(mission_execution).to receive(:abort_count=)
    allow(mission_execution).to receive(:transition_to)
    allow(mission_execution.log).to receive(:print_mission_summary)
  end

  describe '#handle_abort' do
    it 'prints the correct abort message' do
      expect do
        random_abort_strategy.handle_abort(mission_execution)
      end.to output("Mission aborted due to a random event!\n").to_stdout
    end

    it 'increments the abort count' do
      expect(mission_execution).to receive(:abort_count=).with(1)
      random_abort_strategy.handle_abort(mission_execution)
    end

    it 'transitions to the AbortState' do
      expect(mission_execution).to receive(:transition_to).with(instance_of(AbortState))
      random_abort_strategy.handle_abort(mission_execution)
    end

    it 'prints the mission summary' do
      expect(mission_execution.log).to receive(:print_mission_summary).with(mission_execution)
      random_abort_strategy.handle_abort(mission_execution)
    end
  end
end
