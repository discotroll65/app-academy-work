class Temperature
  attr_accessor :f,:c

  def initialize(params = {})
    @f = params.fetch(:f, 32)
    @c = params.fetch(:c, 0)

    if @f != 32
      @c = in_celsius
    else
      @f = in_fahrenheit
    end

  end

  def self.from_celsius(celsius_temp)
    Temperature.new({:c => celsius_temp})
  end

  def self.from_fahrenheit(fahr_temp)
    Temperature.new({:f => fahr_temp})
  end

  def in_celsius
    far_temp_float = f.to_f
    c_temp = (5.0/9) * (far_temp_float - 32)
    c_temp
  end

  def in_fahrenheit
    c_temp_float = c.to_f
    f_temp = (c_temp_float * 9/5.0) + 32
  end

end

class Celsius < Temperature
  def initialize(celsius)
    @c = celsius.to_f
    @f = in_fahrenheit
  end
end

class Fahrenheit < Temperature
  def initialize(fahrenheit)
    @f = fahrenheit
    @c = in_celsius
  end
end
