#"abc"
#"1234"

def reverse!(str)
  i = 0
  len = str.length
  while i < len/ 2
    str[i], str[len - (i + 1)] = str[len - (i + 1)], str[i]
    i += 1
  end

  str
end

# puts reverse!("abc")

def first_non_repeating_char(str)
  hash_map = Hash.new(0)

  i = 0
  while i < str.length
    hash_map[str[i]] += 1
    i += 1
  end
  i = 0
  while i < str.length
    return str[i] if hash_map[str[i]] == 1
    i += 1
  end

  nil
end

# puts first_non_repeating_char("abcabcd")
def is_anagram(str1, str2)
  freq1 = Hash.new(0)
  freq2 = Hash.new(0)
  str1.chars.each { |el| freq1[el] += 1 }
  str2.chars.each { |el| freq2[el] += 1 }

  freq1 == freq2
end

puts is_anagram('bgat', 'ttab')
