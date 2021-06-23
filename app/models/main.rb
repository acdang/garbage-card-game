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

menu(current_player)

continue = TTY::Prompt.new
continue.keypress("---> Press enter to create a NEW GAME\n", keys: [:return])

# Play game ======================================================

# play_game(current_player, cpu_opponent)
# play_game(current_player)

# binding.pry
