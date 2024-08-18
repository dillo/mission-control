# frozen_string_literal: true

# mission_log_spec.rb
require 'rspec'
require_relative '../mission_log'

RSpec.describe MissionLog do
  let(:rocket) do
    double('Rocket', destination_distance: 1000, distance_traveled: 500, average_speed: 100,
                     current_status: { fuel_burn_rate: 10, speed: 100, distance_traveled: 500 }, total_fuel_burned: 500)
  end
  let(:mission) { double('Mission', rocket:, abort_count: 2, explosion_count: 1, elapsed_time: 3600) }
  let(:missions) { [mission, mission] }

  describe '#print_mission_status' do
    it 'prints the current status of the mission' do
      expect { subject.print_mission_status(rocket, 3600) }.to output(/Mission status:/).to_stdout
    end
  end

  describe '#print_mission_summary' do
    it 'prints the summary of the mission' do
      expect { subject.print_mission_summary(mission) }.to output(/Mission summary:/).to_stdout
    end
  end

  describe '#print_all_missions_status' do
    it 'prints the status of all missions' do
      expect { subject.print_all_missions_status(missions) }.to output(/All missions Summary:/).to_stdout
    end
  end

  describe '#format_time' do
    it 'formats 0 seconds as "00:00:00"' do
      expect(subject.send(:format_time, 0)).to eq('00:00:00')
    end

    it 'formats 3661 seconds as "01:01:01"' do
      expect(subject.send(:format_time, 3661)).to eq('01:01:01')
    end

    it 'formats 86399 seconds as "23:59:59"' do
      expect(subject.send(:format_time, 86_399)).to eq('23:59:59')
    end

    it 'formats 3600.5 seconds as "01:00:00"' do
      expect(subject.send(:format_time, 3600.5)).to eq('01:00:00')
    end

    it 'formats 3661.5 seconds as "01:01:01"' do
      expect(subject.send(:format_time, 3661.5)).to eq('01:01:01')
    end
  end
end
