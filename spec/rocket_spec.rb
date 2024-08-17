# frozen_string_literal: true

require_relative 'spec_helper'
require_relative '../rocket'

RSpec.describe Rocket do
  let(:rocket) do
    Rocket.new(fuel_capacity: 1_514_100, burn_rate: 168_233, payload_capacity: 50_000, average_speed: 1500)
  end

  it 'initializes with default attributes' do
    expect(rocket.fuel_capacity).to eq(1_514_100)
    expect(rocket.burn_rate).to eq(168_233)
    expect(rocket.payload_capacity).to eq(50_000)
    expect(rocket.average_speed).to eq(1500)
  end
end
