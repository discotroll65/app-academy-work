#need to see 'qu' as a consonant
#need to slice all 'consonants' until we see a vowel
#put the consonants in the back of the word


def translate(phrase)
  #split phrase into words
  word_array = phrase.split ' '
  #to_pig each word
  answer_array = word_array.map {|word| to_pig(word)}
  #join words back together
  answer = answer_array.join ' '
end

def to_pig (word)
  #list all the vowels
  vowel_list = ['a','e', 'i', 'o', 'u','y']
  #list all punctuation
  punctuation_list = ['.',',','?','!',':',';']

  letters_array = word.split('')

  last_character = letters_array[letters_array.length - 1]
  punct = ''
  if punctuation_list.include?(last_character)
    punct = letters_array.pop
  end

  #if starts with a vowel, then return word with 'ay' on end
  return word + 'ay' + punct if vowel_list.include?(word[0])

  #starts with consonant, need to find the index where vowels start(not counting u after q)
  vowel_index = nil 


  i = 0
  while i < letters_array.length && vowel_index == nil
    if vowel_list.include?(letters_array[i])
      if (letters_array[i] == 'u' || letters_array[i] == 'U') && (letters_array[i-1] == 'q' || letters_array[i-1] == 'Q' )
        vowel_index = i + 1
      else
        vowel_index = i
      end
    end
    i += 1
  end
  #slice to that index, add to end of word.
  word_no_punct = letters_array.join
  root = word_no_punct.slice(vowel_index..(word_no_punct.length - 1)) 
  prefix = word_no_punct.slice(0..vowel_index - 1) 

  #capitalization
  if word_no_punct[0] == word_no_punct[0].upcase
    root = root[0].upcase + root.slice(1..(root.length - 1))
    prefix = prefix[0].downcase + prefix.slice(1..(prefix.length - 1))
  end
  
  answer = root + prefix  + 'ay' + punct
  
end
