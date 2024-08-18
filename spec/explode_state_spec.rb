# frozen_string_literal: true

# spec/explode_state_spec.rb
require_relative '../explode_state'
require_relative '../mission_execution'

RSpec.describe ExplodeState do
  let(:explode_state) { ExplodeState.new }
  let(:mission_execution) { MissionExecution.new(stages: [], rocket: double('Rocket'), log: double('Log')) }

  describe '#handle_mission' do
    context 'when explode_count is greater than 0' do
      it 'does not call explode_mission' do
        mission_execution.explosion_count = 1
        expect(mission_execution).not_to receive(:explode_mission)

        explode_state.handle_mission(mission_execution)
      end
    end

    context 'when explode_count is 0' do
      it 'calls explode_mission' do
        mission_execution.explosion_count = 0
        expect(mission_execution).to receive(:explode_mission)

        explode_state.handle_mission(mission_execution)
      end
    end
  end
end
