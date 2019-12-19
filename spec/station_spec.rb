require 'station'

describe Station do

  it 'initializes with station name' do
    kings_cross = Station.new('Kings Cross', 1)
    expect(kings_cross.name).to eq 'Kings Cross'
  end

  it 'initializes with station zone' do
    kings_cross = Station.new('Kings Cross', 1)
    expect(kings_cross.zone).to eq 1
  end

end