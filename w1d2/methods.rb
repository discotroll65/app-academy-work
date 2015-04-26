#Implement a Rock, Paper, Scissors game. The method rps should
#take a string (either "Rock", "Paper" or "Scissors") as a
#parameter and return the computer's choice, and the outcome
# of the match. Example:
#rps("Rock") # => "Paper, Lose"
def rps(choice)
  possible_choices = %w[Rock Paper Scissors]
  computer_choice = possible_choices.shuffle[0]

  win_conditions = {
    :Rock => {
      Rock: "Draw",
      Scissors: "Win",
      Paper: "Lose"
    },
    :Paper => {
      Rock: "Win",
      Scissors: "Lose",
      Paper: "Draw"
    },
    :Scissors => {
      Rock: "Lose",
      Scissors: "Draw",
      Paper: "Win"
    }
  }

  result = win_conditions[choice.to_sym][computer_choice.to_sym]

  puts "#{computer_choice}, #{result}"
end

#Implement a Mixology game. The method remix should take an array
# of ingredient arrays (one alcohol, one mixer) and return the
# same type of data structure, with the ingredient pairs randomly
#  mixed up. Assume that the first item in the pair array is 
#  alcohol, and the second is a mixer. Don't pair an alcohol
#   with an alcohol with or a mixer with a mixer. An example run
#    of the program:
# remix([
#  ["rum", "coke"],
#    ["gin", "tonic"],
#      ["scotch", "soda"]
#      ])
#      #=> [["rum, "tonic"], ["gin", "soda"], ["scotch", "coke"]]
def remix(ingredient_arrays)
  alcohols, mixers, result = [], [], []

  ingredient_arrays.each do |pair|
    alcohols << pair[0]
    mixers << pair[1]
  end

  alcohols.shuffle!

  i = 0
  while i < ingredient_arrays.size
    result << [alcohols[i], mixers[i]]
    i += 1
  end

  result
end
