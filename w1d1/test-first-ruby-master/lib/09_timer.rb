class Timer
  attr_accessor :seconds

  def seconds(value=0)
    @seconds = value
  end

  def time_string
    #take number of seconds
    #find hours, take remainder
    #find minutes, take remainder
    #find seconds 
    int_seconds = @seconds.to_i
    hours = int_seconds/ 3600
    extra_from_hours = int_seconds % 3600
    
    minutes = extra_from_hours / 60
    extra_from_minutes = extra_from_hours % 60

    seconds = extra_from_minutes

    "#{0 if hours < 10}#{hours}:#{0 if minutes < 10}#{minutes}:#{0 if seconds < 10}#{seconds}"
  end

end
