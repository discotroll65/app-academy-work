class Array
  def sum
    result = 0
    self.each {|i| result += i}
    result
  end

  def square
    result = self.map {|i| i*i}
  end

  def square!
    self.each_with_index {|number,index| self[index] = number * number}
  end
end
