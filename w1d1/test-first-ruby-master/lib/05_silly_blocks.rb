def reverser
  phrase = yield
  words_array = phrase.split ' '

  answer_array = words_array.map do |word|
    letters_array = word.split ''
    reversed_array = []

    letters_array.each do |letter|
      reversed_array.unshift(letter)
    end

    result = reversed_array.join ''
  end

  result = answer_array.join ' '
end

def adder (amount_adding = 1)
  number = yield
  number + amount_adding
end

def repeater (frequency = 1)
  frequency.times do
    yield
  end
end
