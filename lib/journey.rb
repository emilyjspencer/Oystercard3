class Journey
  attr_reader :journey

  def initialize
    @journey = {:touch_in => nil, :touch_out => nil }
  end

 def add_touch_in(station)
   @journey[:touch_in] = station
 end 

  def add_touch_out(station)
    @journey[:touch_out] = station
  end 

  def show_touch_in
    @journey[:touch_in]
  end

end