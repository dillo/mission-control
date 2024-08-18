# frozen_string_literal: true

# spec/abort_state_spec.rb
require_relative '../abort_state'
require_relative '../mission_execution'

RSpec.describe AbortState do
  let(:abort_state) { AbortState.new }
  let(:mission_execution) { instance_double('MissionExecution') }

  describe '#handle_mission' do
    context 'when abort_count is greater than 0' do
      it 'does not call abort_mission' do
        allow(mission_execution).to receive(:abort_count).and_return(1)
        expect(mission_execution).not_to receive(:abort_mission)

        abort_state.handle_mission(mission_execution)
      end
    end

    context 'when abort_count is 0' do
      it 'calls abort_mission' do
        allow(mission_execution).to receive(:abort_count).and_return(0)
        expect(mission_execution).to receive(:abort_mission)

        abort_state.handle_mission(mission_execution)
      end
    end
  end
end
