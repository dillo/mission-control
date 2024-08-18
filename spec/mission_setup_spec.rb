# frozen_string_literal: true

# spec/mission_setup_spec.rb

require_relative '../mission_setup'

RSpec.describe MissionSetup do
  describe '#initialize' do
    it 'sets the mission name to nil' do
      setup = MissionSetup.new
      expect(setup.name).to be_nil
    end
  end

  describe '#set_name' do
    it 'prompts the user and sets the mission name' do
      setup = MissionSetup.new
      allow(setup).to receive(:gets).and_return('Apollo')
      expect { setup.set_name }.to output("What is the name of this mission?\n").to_stdout
      expect(setup.name).to eq('Apollo')
    end
  end

  describe '#display_default_plan' do
    it 'outputs the default mission plan' do
      setup = MissionSetup.new
      expected_output = <<~PLAN
        Mission plan:
          Travel distance:  160.0 km
          Payload capacity: 50,000 kg
          Fuel capacity:    1,514,100 liters
          Burn rate:        168,240 liters/min
          Average speed:    1,500 km/h
          Random seed:      12
      PLAN
      expect { setup.display_default_plan }.to output(expected_output).to_stdout
    end
  end

  describe '#confirm_mission?' do
    it 'returns true if the user confirms with y' do
      setup = MissionSetup.new
      allow(setup).to receive(:gets).and_return('y')
      expect { setup.confirm_mission? }.to output("Would you like to proceed? (Y/n)\n").to_stdout
      expect(setup.confirm_mission?).to be true
    end

    it 'returns false if the user does not confirm with y' do
      setup = MissionSetup.new
      allow(setup).to receive(:gets).and_return('n')
      expect { setup.confirm_mission? }.to output("Would you like to proceed? (Y/n)\n").to_stdout
      expect(setup.confirm_mission?).to be false
    end
  end
end
