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

  def merge_sort
    return self if self.size < 2
    

    middle =  self.count / 2 - 1
    left = self[0..middle].merge_sort
    right = self[middle+1..-1].merge_sort

    self.class.merge(left , right)
  end

  def self.merge(left, right)
    result = []
    until left.empty? ||  right.empty?
      comparison = left[0] <=> right[0]

      case comparison
      when 1
        result << right.shift
      when 0
        result << left.shift
        result << right.shift
      when -1
        result << left.shift
      end
    end

    result + right.merge_sort + left.merge_sort
  end

 


  def deep_dup
    inject([]){|memo, el| memo << (el.is_a?(Array) ? el.deep_dup : el) }
  end

end



def fib_it(n)
  return [0] if n == 0
  return [0 , 1] if n == 1 
  result = []
  first = 0
  second = 1
  result.push(0, 1)

  until result.size == n + 1
    result << first + second
    second = result[-1]
    first = result[-2]
  end
  result
end

def fib_rec(n)
  return [0] if n == 0
  return [1] if n == 1
  fib_rec(n-1) + [fib_rec(n - 1).last + fib_rec(n - 2).last]

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

def make_change_sol(target, coins = [25, 10, 5, 1])
  # Don't need any coins to make 0 cents change
  return [] if target == 0
  # Can't make change if all the coins are too big. This is in case
  # the coins are so weird that there isn't a 1 cent piece.
  return nil if coins.none? { |coin| coin <= target }

  # Optimization: make sure coins are always sorted descending in
  # size. We'll see why later.
  coins = coins.sort.reverse

  best_change = nil
  coins.each_with_index do |coin, index|
    # can't use this coin, it's too big
    next if coin > target

    # use this coin
    remainder = target - coin

    # Find the best way to make change with the remainder (recursive
    # call). Why `coins.drop(index)`? This is an optimization. Because
    # we want to avoid double counting; imagine two ways to make
    # change for 6 cents:
    #   (1) first use a nickle, then a penny
    #   (2) first use a penny, then a nickle
    # To avoid double counting, we should require that we use *larger
    # coins first*. This is what `coins.drop(index)` enforces; if we
    # use a smaller coin, we can never go back to using larger coins
    # later.
    best_remainder = make_change(remainder, coins.drop(index))

    # We may not be able to make the remaining amount of change (e.g.,
    # if coins doesn't have a 1cent piece), in which case we shouldn't
    # use this coin.
    next if best_remainder.nil?

    # Otherwise, the best way to make the change **using this coin**,
    # is the best way to make the remainder, plus this one coin.
    this_change = [coin] + best_remainder

    # Is this better than anything we've seen so far?
    if (best_change.nil? || (this_change.count < best_change.count))
      best_change = this_change
    end
  end

  best_change
end

def reverse(n)
  return n if n.to_s.split('').size == 1
  string_num = n.to_s.split('')

  middle = string_num.size / 2 - 1
  left = string_num[0..middle]
  right = string_num[middle + 1..-1]

  reversed_string = reverse(right.join('').to_i).to_s +
    reverse(left.join('').to_i).to_s
  reversed_string.to_i
end

# returns array of coins
def make_change(amount, coins = [25, 10, 5, 1] )
  coins.sort!.reverse
  return nil if amount < coins.last
  return [amount] if coins.include?(amount)
  divisible_coins = coins.select{|i| amount % i == 0 && i > 1}
  unless divisible_coins.empty?
    coin_and_freq = [divisible_coins.first, amount / divisible_coins.first]
  end

  biggest_coin = find_biggest_coin(amount, coins)

  if  !coin_and_freq.nil?
    return [coin_and_freq[0]] * coin_and_freq[1] if make_change(amount - biggest_coin, coins).size + 1 > coin_and_freq[1] 
  end

  [biggest_coin] + make_change(amount - biggest_coin, coins)

end


def find_biggest_coin(amount, coins)
  coins.each {|coin| return coin if coin < amount}
end

# def subsets(array)
#   return [[]]  if array.empty?
# 
#   final = array.dup
#   sub_of_array = subsets(array[0...-1])
# 
#   array.each do |el|
#     next_subs = subsets( array - [el]  ).reject{|inner_el| inner_el.empty?}
# 
#     next_subs.each do |sub|
#       sub_of_array << sub
#     end
#   end
#   sub_of_array << final
#   sub_of_array.uniq
# end

  def subsets(array)

    return [[]] if array.empty?
    val = array[-1]
    result = subsets(array[0...-1])

    last_set = subsets(array[0...-1]).map{|el| el << val}
    result + last_set
  end

