class Array
  def my_each(&prc)
    i = 0
    while i < self.count
      prc.call(self[i])
      i += 1
    end
  end

  def my_map(&prc)

    [].tap do |arr|
      i = 0
      while i < self.count
        arr << prc.call(self[i])
        i += 1
      end
    end

  end

  def my_select(&prc)
    arr = []

    i = 0
    while i < self.count
      arr << self[i] if prc.call(self[i])
      i += 1
    end
    arr
  end

  def my_inject(&prc)
    sum = self[0]
    self[1..self.length-1].my_each do |val|
      sum = prc.call(sum, val)
    end
    sum

  end

  def my_sort!(&prc)
    sorted = false
    until sorted
      sorted = true

      self[0..-2].each_index do |indx|
        if prc.call( self[indx], self[indx +1] ) == 1
          sorted = false
          self[indx] , self[indx + 1] = self[indx + 1], self[indx]
        end
      end

    end
    self
  end

end


def eval_block(*args, &prc)
  unless block_given?
    puts "NO BLOCK GIVEN"
    return
  end

  prc.call(args)
end

eval_block("Kerry", "Washington", 23) do |fname, lname, score|
  puts "#{lname}, #{fname} won #{score} votes."
end
