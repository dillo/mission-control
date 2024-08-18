# frozen_string_literal: true

# spec/normal_state_spec.rb

require_relative '../normal_state'

RSpec.describe NormalState do
  describe '#handle_mission' do
    let(:mission_execution) { double('MissionExecution') }
    let(:log) { double('Log') }
    let(:normal_state) { NormalState.new }

    before do
      allow(mission_execution).to receive(:launch_rocket)
      allow(mission_execution).to receive(:log).and_return(log)
      allow(log).to receive(:print_mission_summary)
    end

    it 'calls launch_rocket on the mission_execution object' do
      normal_state.handle_mission(mission_execution)
      expect(mission_execution).to have_received(:launch_rocket)
    end

    it 'calls print_mission_summary on the log object of mission_execution' do
      normal_state.handle_mission(mission_execution)
      expect(log).to have_received(:print_mission_summary).with(mission_execution)
    end
  end
end
