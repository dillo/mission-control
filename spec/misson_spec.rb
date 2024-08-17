# frozen_string_literal: true

require_relative 'spec_helper'
require_relative '../mission'
require_relative '../rocket'

RSpec.describe Mission do
  let(:rocket) do
    Rocket.new(fuel_capacity: 1_514_100, burn_rate: 168_233, payload_capacity: 50_000, average_speed: 1500)
  end
  let(:mission) { described_class.new(name: 'First Mission', rocket:) }

  it 'initializes with a name attribute' do
    expect(mission.name).to eq('First Mission')
  end

  it 'initializes with a rocket' do
    expect(mission.rocket).to be_a(Rocket)
  end
end
