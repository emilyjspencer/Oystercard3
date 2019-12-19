require 'journey_log'

describe JourneyLog do

  let(:old_street){double('old_street')}
   let(:journey){double :journey, :add_touch_in => nil, :add_touch_out => nil}
   let(:journey_class){double :journey_class, :new => journey}

   subject{JourneyLog.new(journey_class)}

  it 'initializes with a journey class parameter' do
    new_log = JourneyLog.new(journey_class)
    expect(new_log.journey_class.new).to eq journey 
  end

  it 'journeys array is empty by default' do
    expect(subject.journeys).to eq []
  end

  it 'when #start is called, entry station added to new journey class' do
    expect(journey).to receive(:add_touch_in).with(old_street)
    subject.start(old_street)
  end

  it 'when #finish is called, exit station added to current_journeys' do
     allow(journey).to receive(:journey)
     subject.start(old_street)
     expect(journey).to receive(:add_touch_out).with(old_street)
     subject.finish(old_street)
   end

   it 'when #finish is called, journey added to @journeys' do
     journey_taken = {:touch_in => old_street, :touch_out => old_street}
     allow(journey).to receive(:journey).and_return(journey_taken)
     subject.start(old_street)
     subject.finish(old_street)
     expect(subject.instance_variable_get(:@journeys)).to eq [journey_taken]
   end

   it 'when #finish is called, current_journeys set back to new journey' do
     allow(journey).to receive(:journey)
     subject.start(old_street)
     journey2 = double('journey2')
     allow(journey_class).to receive(:new).and_return(journey2)
     expect{subject.finish(old_street)}.to change{subject.instance_variable_get(:@current_journey)}.from(journey).to(journey2)
   end
   
   it '#entry_station returns entry station of current journey' do
     allow(journey).to receive(:show_touch_in).and_return(old_street)
     subject.start(old_street)
     expect(subject.entry_station).to eq old_street
   end

   it 'returns a list of journeys taken' do
     journey_taken = {:touch_in => old_street, :touch_out => old_street}
     allow(journey).to receive(:journey).and_return(journey_taken)
     subject.start(old_street)
     subject.finish(old_street)
     expect(subject.journeys[0][:touch_in]).to eq old_street
     expect(subject.journeys[0][:touch_out]).to eq old_street
   end

   it 'expect mutation of returned list of journeys not to change original list of journeys' do
     journey_taken = {:touch_in => old_street, :touch_out => old_street}
     allow(journey).to receive(:journey).and_return(journey_taken)
     subject.start(old_street)
     subject.finish(old_street)
     journey_list = subject.journeys
     expect{journey_list[0][:touch_in] = nil}.not_to change{subject.instance_variable_get(:@journeys)}.from([journey_taken])
   end
end