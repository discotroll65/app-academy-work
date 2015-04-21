class RPNCalculator
  attr_accessor :stack

  def initialize
    @stack = []
  end

  def push (value)
    stack.push(value)
  end


  def value
    result = stack.pop
    stack.push(result)
    result
  end

  def operate(operation)
    raise "calculator is empty" if value == nil
    token1 = stack.pop.to_f
    token2 = stack.pop.to_f
    result = eval("token2 #{operation} token1")
    stack.push(result)
  end

  def plus
    operate(:+)
  end

  def minus
    operate(:-)
  end

  def divide
    operate(:/)
  end

  def times
    operate(:*)
  end
  
  def tokens (token_string)
    characters = token_string.split ' '
    result = characters.map do |character|
      if character.to_i.to_s == character
        character.to_i
      else
        character.to_sym
      end
    end

    result
  end

  def evaluate(token_string)
    rpn_stack = tokens(token_string)
    result = nil

    while rpn_stack.length > 1
      self.stack = []

      i = 2
      j = 1
      k = 0

      while rpn_stack[i].is_a? Fixnum
       i += 1
       j += 1
       k += 1
      end 

      operator = rpn_stack.delete_at i
      stack.unshift(rpn_stack.delete_at j)
      stack.unshift(rpn_stack.delete_at k)
      operate(operator)

      rpn_stack.insert(k, value)
    end
    result = rpn_stack[0]
  end
end
