class Fixnum
  def in_words
    stringed = self.to_s

    num_digits = stringed.length

    if num_digits == 1
      ones_place_words
    elsif num_digits == 2
      tens_wordify.strip
    elsif num_digits == 3
      hundreds_wordify.strip
      #thousands
    elsif num_digits < 7
      hundreds = stringed.slice!(-3..-1).to_i
      thousands = stringed.to_i
      (thousands.thousands_wordify + hundreds.hundreds_wordify).strip
      #millions  
    elsif num_digits < 10
      hundreds = stringed.slice!(-3..-1).to_i
      thousands = stringed.slice!(-3..-1).to_i
      millions = stringed.to_i
      (millions.millions_wordify + thousands.thousands_wordify + 
       hundreds.hundreds_wordify).strip
      #billions
    elsif num_digits < 13
      hundreds = stringed.slice!(-3..-1).to_i
      thousands = stringed.slice!(-3..-1).to_i
      millions = stringed.slice!(-3..-1).to_i
      billions = stringed.to_i
      (billions.billions_wordify + millions.millions_wordify + 
       thousands.thousands_wordify + 
       hundreds.hundreds_wordify).strip
      #trillions  
    elsif num_digits < 16
      hundreds = stringed.slice!(-3..-1).to_i
      thousands = stringed.slice!(-3..-1).to_i
      millions = stringed.slice!(-3..-1).to_i
      billions =  stringed.slice!(-3..-1).to_i
      trillions = stringed.to_i
      (trillions.trillions_wordify + billions.billions_wordify + 
       millions.millions_wordify + 
       thousands.thousands_wordify + 
       hundreds.hundreds_wordify).strip
    end

  end

  def ones_place_words
    if self == 0
      'zero'
    elsif self == 1
     'one'
    elsif self == 2
     'two'
    elsif self == 3
     'three'
    elsif self == 4 
      'four'
    elsif self == 5
      'five'
    elsif self == 6
      'six'
    elsif self == 7
      'seven'
    elsif self == 8
      'eight'
    elsif self == 9
      'nine'
    end
  end


  def ten_thru_twelve
    if self == 10
      'ten'
    elsif self == 11
     'eleven'
    elsif self == 12
     'twelve'
    end
  end
  
  def teens_words
    suffix = 'teen'
    if self == 13
     'thir' + suffix
    elsif self == 14
      'four'  + suffix

    elsif self == 15
      'fif' + suffix

    elsif self == 16
      'six' + suffix
    elsif self == 17
      'seven'+ suffix

    elsif self == 18
      'eigh'+ suffix

    elsif self == 19
      'nine'+ suffix
    end
  end

  def tens_words
    suffix = 'ty'
    if self == 2
     'twen' + suffix
    elsif self == 3
      'thir'  + suffix
    elsif self == 4
      'for'  + suffix
    elsif self == 5
      'fif'+ suffix
    elsif self == 6
      'six'+ suffix
    elsif self == 7
      'seven'+ suffix
    elsif self == 8
      'eigh'+ suffix
    elsif self == 9
      'nine'+ suffix
    end
  end 

  def tens_wordify
    if self == 0
      ''
    elsif self < 10
      ones_place_words
    elsif self < 13
      ten_thru_twelve
    elsif self < 20
      teens_words
    else self < 100
      tens = self.to_s[0].to_i
      ones = self.to_s[1].to_i
      ones_part = ones.ones_place_words unless ones == 0
      result = tens.tens_words + ' ' + ones_part.to_s
      result.strip
    end
  end

  def hundreds_wordify
    return self.tens_wordify if self < 100
    stringed = self.to_s
    tens = stringed.slice(1..2).to_i
    hundred = stringed[0].to_i

    if hundred == 0
      hundreds_lead = ' '
    else
      hundreds_lead = hundred.ones_place_words + ' hundred '
    end
    
    hundreds_lead + tens.tens_wordify
  end

  def thousands_wordify
    return '' if self == 0
    result = self.hundreds_wordify + ' thousand '
    result
  end

  def millions_wordify
    return '' if self == 0
    result = self.hundreds_wordify + ' million '
    result
  end

  def billions_wordify
    return '' if self == 0
    result = self.hundreds_wordify + ' billion '
    result
  end

  def trillions_wordify
    result = self.hundreds_wordify + ' trillion '
    result
  end

end
