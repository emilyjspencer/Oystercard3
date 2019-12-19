require 'journey'

describe Journey do


  it 'journeys is empty by default' do
    expect(subject.journey).to eq ({:touch_in => nil, :touch_out => nil})
  end


  it 'records entry station after adding entry station' do
    old_street = double("old_street")
    subject.add_touch_in(old_street)
    expect(subject.show_touch_in).to eq old_street
  end

  it 'records exit station after adding exit station' do
    old_street = double("old_street")
    subject.add_touch_out(old_street)
    expect(subject.journey[:touch_out]).to eq old_street
  end

end