class Book
  attr_accessor :title

  def title=(name)
    non_caps = ['of','the', 'a','an','and','in']
    word_array = name.split ' '
    cap_array = word_array.map do |word|
      if non_caps.include? word
        word
      else
        word.capitalize
      end
    end
    result = cap_array.join ' '
    result[0] = result[0].upcase
    @title = result
  end
end
