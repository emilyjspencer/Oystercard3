require_relative 'journey_log'
require_relative 'journey'

class Oystercard

    attr_reader :balance

    MAX_LIMIT = 90
    MIN_LIMIT = 1
    MIN_FARE = 2
    PENALTY_FARE = 6

    def initialize(balance = 0)
        @balance = balance
        @journeylog = JourneyLog.new(Journey)
    end

    def top_up(value)
        fail "Error: Maximum limit of #{MAX_LIMIT.to_s} reached" if exceeds_max?(value)
        @balance += value
    end

    def touch_in(station)
      fail "Not enough credit" if min_amount?
      journeylog.start(station)
    end

    def touch_out(station = nil)
      station == nil || journeylog.entry_station == nil ? deduct(PENALTY_FARE) : deduct(MIN_FARE)
      journeylog.finish(station)
    end

    def show_journeys
      journeylog.journeys 
    end 

    private

    def journeylog
      @journeylog
    end 

    def exceeds_max?(value)
      @balance + value >= MAX_LIMIT
    end

    def min_amount?
      @balance <= MIN_LIMIT
    end

    def deduct(value)
      @balance -= value
    end
end