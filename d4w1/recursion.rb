require 'byebug'
require 'pry'

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


def arr_sum(arr)
  return arr[0] if arr.count == 1
  arr.last + arr_sum(arr[0..-2])

end


def exp1(b, n)
  return 1 if n == 0
  b * exp1(b, n-1)
end


def exp2(b, n)
  return 1 if n == 0
  return b if n == 1
  return b * exp2(b, (n-1) / 2) * exp2(b, (n-1) / 2) if n.odd?
  return  exp2(b, n / 2) * exp2(b, n / 2) if n.even?
end


class Array

  def deep_dup
    inject([]){|memo, el| memo << (el.is_a?(Array) ? el.deep_dup : el) }
  end

end


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
