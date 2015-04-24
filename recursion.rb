require 'byebug'

def range(start_num, end_num)
  return [] if start_num > end_num
  if end_num - start_num == 1
    return [start_num, end_num]
  end

  range(start_num,end_num-1) +[end_num]
end

def iter_array_sum(array)
  sum = 0
  array.each do |el|
    sum += el
  end
  sum
end

# p iter_array_sum([1,2,3,4])

def arr_sum(arr)
  return arr[0] if arr.count == 1
  arr.last + arr_sum(arr[0..-2])

end

# p arr_sum([1,2,3,4])

def exp1(b, n)
  return 1 if n == 0
  b * exp1(b, n-1)
end

# p exp1(2,3)

def exp2(b, n)
  return 1 if n == 0
  return b if n == 1
  return b * exp2(b, (n-1) / 2) * exp2(b, (n-1) / 2) if n.odd?
  return  exp2(b, n / 2) * exp2(b, n / 2) if n.even?
end

# p exp2(2,8)

class Array

  def deep_dup (el = 0)


    # self.each_with_index do |el, indx|
    #   if !el.is_a? Array
    #     return [el]
    #   else
    #   end
    # end
  end
end

# robot_parts = [
#   ["nuts", "bolts", "washers"],
#   ["capacitors", "resistors", "inductors"]
# ]
#
# robot_parts_copy = robot_parts.deep_dup
#
# # shouldn't modify robot_parts
# robot_parts_copy[1] << "LEDs"
# # wtf?
# # p robot_parts[1] # => ["capacitors", "resistors", "inductors", "LEDs"]
#




def bsearch(arr, target)
  return nil if arr.count == 0
  if arr.count == 1
    return target == arr[0] ? 0 : nil
  end

  middle_index = (arr.count / 2)

  if target == arr[middle_index]
    return middle_index
  end

  if target < arr[middle_index]
    bsearch(arr[0..middle_index-1], target)
  else
    result = bsearch(arr[middle_index..-1], target)
    if result
      middle_index + result
    else
      nil
    end

  end
end


p bsearch([1, 2, 3], 1) # => 0
#p bsearch([2, 3, 4, 5], 7) # => 1
# p bsearch([2, 4, 6, 8, 10], 6) # => 2
# p bsearch([1, 3, 4, 5, 9], 5) # => 3
# p bsearch([1, 2, 3, 4, 5, 6], 6) # => 5
# p bsearch([1, 2, 3, 4, 5, 6], 0) # => nil
# p bsearch([1, 2, 3, 4, 5, 7], 6) # => nil




# def make_change(amount, coins = [25, 10, 5, 1] )
#   biggest = find_biggest_coin(amount)
#
#   coins.each do |coin|
#     if coin < amount
#       if amount % coin == 0
#         num_coins = amount / coin
#         return Array.new(num_coins) {coin}
#       else
#         remainder ||= amount % coin
#         biggest ||= coin
#       end
#     end
#
#   end
#
# end
#
# def find_biggest_coin(amount, coins)
#   coins = coins.sort! { |y,x| x <=> y}
#   coins.each do {|coin| return coin if coin < amount}
# end
