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

# return Player instance of the winner of a round
def round_winner(round_id, current_player, cpu_opponent)

end

def total_num_games
    
end

def num_games_won
    
end

def display_stats(current_player)
    # display total num of games played

    # display total num of games won

end

puts "STATS WILL GO HERE"
puts "\n"

continue = TTY::Prompt.new
continue.keypress("---> Press enter to create a NEW GAME\n", keys: [:return])

binding.pry
# Play game ======================================================
play_game()


binding.pry
