require_relative "player"
require_relative "play_round"
require_relative "round"
require_relative "main_methods"

require 'pry'

require "tty-prompt"

# Welcome ======================================================

puts "Welcome to Garbage, a card game!"
puts "\n"

# Handle player ======================================================
current_player = handle_player()

# Home stats ======================================================

def display_stats(current_player)
    #display total number of completed games by player
    puts "Number of completed games: #{current_player.total_num_completed_games}"

    # display total num of games won

end

display_stats(curent_player)

continue = TTY::Prompt.new
continue.keypress("---> Press enter to create a NEW GAME\n", keys: [:return])

binding.pry
# Play game ======================================================
play_game()


binding.pry
