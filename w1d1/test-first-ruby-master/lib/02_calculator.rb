def add (num1 ,num2)
  answer = num1 + num2
  answer
end

def subtract (num1, num2)
  answer = num1 - num2
  answer
end

def sum (array)
  total = 0
  array.each {|number| total += number}
  total
end

def multiply(array)
  answer = 1
  array.each {|number| answer *= number}
  answer
end

def power(base, exponent)
  answer = base ** exponent
  answer
end

def factorial (number)
  return 1 if number == 0
  n = number

  answer = 1
  while n > 0
    answer *= n
    n -= 1    
  end
  answer
end
