

class JourneyLog
  attr_reader :journey_class

  def initialize(journey_class_inject)
    @journey_class = journey_class_inject
    @journeys = []
    @current_journey = journey_class.new
  end

  def start(station)
    @current_journey.add_touch_in(station)
  end

  def finish(station)
    @current_journey.add_touch_out(station)
    @journeys << @current_journey.journey
    @current_journey = journey_class.new
  end

  def entry_station
    @current_journey.show_touch_in
  end 

  def journeys
    @journeys.map { |journey| journey.clone }
  end 

end