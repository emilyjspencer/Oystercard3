require 'oystercard'

describe Oystercard do

  let(:old_street){ double :old_street, :name => 'old_street', :zone => 1 }
  let(:kings_cross){ double :kings_cross, :name => 'kings_cross', :zone => 1 }

  it 'initializes with a default balance' do
      expect(subject.balance).to eq 0
  end

  it 'tops up with the top up value as the argument' do
      expect{ subject.top_up(1) }.to change{ subject.balance }.by 1
  end

  it 'raises an error if the action would take the card beyond the limit' do
      expect{ subject.top_up(100) }.to raise_error "Error: Maximum limit of #{Oystercard::MAX_LIMIT.to_s} reached"
  end

  it 'raises an error when touching in with a balance less or equal to one' do
      old_street = double("old_street", :name => 'Old Street', :zone => 1 )
      expect{ subject.touch_in(old_street) }.to raise_error "Not enough credit"
  end

  it 'reduces balance by minimum fare on touch out' do
    subject.top_up(10)
    subject.touch_in(old_street)
    expect{ subject.touch_out(kings_cross) }.to change{ subject.balance }.by (-Oystercard::MIN_FARE)
  end

  it 'charges penatly fare if exit station not defined' do
    subject.top_up(10)
    subject.touch_in(old_street)
    expect{subject.touch_out}.to change{subject.balance}.by (-6)
  end

  it 'charges penalty fare if entry station not defined' do
    subject.top_up(10)
    expect{subject.touch_out(old_street)}.to change{subject.balance}.by (-6)
  end

end