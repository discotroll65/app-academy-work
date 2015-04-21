class Dictionary
  attr_accessor :map_hash

  def initialize
    @map_hash = {}
  end

  def entries
    map_hash
  end
  
  def add (key_val_pair)
    if key_val_pair.is_a? Hash
      map_hash.merge!(key_val_pair)
    else
      map_hash.store(key_val_pair, nil)
    end
  end

  def keywords
    map_hash.keys.sort!{|x,y| x<=>y}
  end

  def include?(key)
    map_hash.include?(key)
  end

  def find(key)
    if map_hash.include?(key)
      value = map_hash[key]
      answer_hash= {key => value}
    else
      search_prefix = key
      prefix_length = key.length
      hash_keys = map_hash.keys
      matching_keys = []

      hash_keys.each do |key|
        key_prefix = key.slice(0..(prefix_length - 1))
        matching_keys << key if key_prefix == search_prefix
      end

      return {} if matching_keys == []

      answer_hash = {}
      matching_keys.each do |matching_key|
        answer_hash.store(matching_key, map_hash[matching_key])
      end

      answer_hash
    end
  end
  
  def printable
    printable_string = ""
    keywords.each do |key|
      printable_string += "[#{key}] \"#{map_hash[key]}\"\n"
    end
    printable_string.chomp
  end
end
