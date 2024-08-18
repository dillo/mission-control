# frozen_string_literal: true

# spec/release_structure_stage_handler_spec.rb

# spec/release_structure_stage_handler_spec.rb

require_relative '../release_structure_stage_handler'
require_relative '../abort_state'

RSpec.describe ReleaseStructureStageHandler do
  let(:release_structure_stage_handler) { ReleaseStructureStageHandler.new }
  let(:mission_execution) { instance_double('MissionExecution') }

  describe '#process' do
    context 'when user inputs Y or y' do
      it 'releases support structures and returns true' do
        allow(release_structure_stage_handler).to receive(:gets).and_return('Y')
        expect do
          release_structure_stage_handler.process(mission_execution)
        end.to output(%r{Release support structures\? \(Y/n\)\nSupport structures released!\n}).to_stdout
        expect(release_structure_stage_handler.process(mission_execution)).to be true

        allow(release_structure_stage_handler).to receive(:gets).and_return('y')
        expect do
          release_structure_stage_handler.process(mission_execution)
        end.to output(%r{Release support structures\? \(Y/n\)\nSupport structures released!\n}).to_stdout
        expect(release_structure_stage_handler.process(mission_execution)).to be true
      end
    end

    context 'when user inputs n or any other input' do
      it 'transitions to AbortState and returns false' do
        allow(release_structure_stage_handler).to receive(:gets).and_return('n')
        expect(mission_execution).to receive(:transition_to).with(instance_of(AbortState))
        expect(release_structure_stage_handler.process(mission_execution)).to be false

        allow(release_structure_stage_handler).to receive(:gets).and_return('anything_else')
        expect(mission_execution).to receive(:transition_to).with(instance_of(AbortState))
        expect(release_structure_stage_handler.process(mission_execution)).to be false
      end
    end
  end
end
