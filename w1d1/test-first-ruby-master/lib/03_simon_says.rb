def echo(word)
  word
end

def shout (string)
  words = string.split(' ')
  shouted_words = words.map {|word| word.upcase}
  result = shouted_words.join(' ')
  result
end

def repeat (string, freq=2)
  answer_array = []
  freq.times do
    answer_array << string
  end

  result = answer_array.join(' ')
  result
end

def start_of_word (word, depth)
  index_depth = depth-1
  answer = word.slice(0..index_depth)
  answer
end

def first_word(phrase)
  words_array = phrase.split(' ')
  answer = words_array[0]
  answer
end

def titleize(phrase)
  words_array = phrase.split(' ')
  little_words = ['over','the','and','in','a','of']
  
  first_word = words_array.shift

  cap_first_word = capitalize_word(first_word) 

  titleized_array = words_array.map do |word|
    unless little_words.include?(word) 
      word = capitalize_word(word) 
    else
      word
    end
  end

  titleized_array.unshift(cap_first_word)

  answer = titleized_array.join(' ') 
end

def capitalize_word (word)
  word[0].upcase + word.slice(1..(word.length - 1))
end
