require_relative "player"
require 'pry'

require "tty-prompt"

def get_first_name
    f_name = TTY::Prompt.new
    puts "\n"
    f_name.ask("Enter your FIRST name:") do |q|
        q.required  true
        q.validate  /\A\w+\Z/
        q.modify    :capitalize
    end
end

def get_last_name
    l_name = TTY::Prompt.new

    l_name.ask("Enter your LAST name:") do |q|
        q.required  true
        q.validate  /\A\w+\Z/
        q.modify    :capitalize
    end
end

def sign_up
    puts "---> SIGN UP\n"

    f_name = get_first_name()
    l_name = get_last_name()

    puts "\n"
    registered = TTY::Prompt.new
    registered.ok("Hello, #{f_name} #{l_name}!")
    puts "\n"
    # Player.new_player(f_name, l_name) # UNCOMMENT THIS LATER!!!!!!!!
end

# check if Player exists
def check_player
    user_exists = false

    while user_exists == false
        puts "---> LOG IN\n"

        f_name = get_first_name()
        l_name = get_last_name()

        if Player.check_player(f_name, l_name)
            puts "\n"
            exist = TTY::Prompt.new
            exist.ok("Hello, #{f_name} #{l_name}!")
            puts "\n"
            user_exists = true
        else
            puts "\n"
            not_exist = TTY::Prompt.new
            not_exist.error("That user does not exist.")
            puts "\n"
        end
    end
end

# Welcome ======================================================

puts "Welcome to Garbage, a card game!"
puts "\n"

# Handle player ======================================================

new_player = TTY::Prompt.new
# new_player.yes?("Are you a new player?") # change to select?
options = [{name: "New Player", value: 1}, {name: "Returning Player", value: 2}]
status = new_player.select("What's your status?", options)
puts "\n"

# create new Player if yes
if status == 1
    sign_up()
# check Player if no
else
    check_player()
end
# Display stats ======================================================

puts "STATS WILL GO HERE"
puts "\n"

# Create new game ======================================================
continue = TTY::Prompt.new(active_color: :cyan)
continue.keypress("---> Press enter to create a NEW GAME\n", keys: [:return])

current_game = Game.new_game

# Choose opponent ======================================================

opponent_prompt = TTY::Prompt.new

opponent1 = Player.first
opponent2 = Player.second
opponent3 = Player.third

choices = [
    {name: opponent1.full_name, value: opponent1},
    {name: opponent2.full_name, value: opponent2},
    {name: opponent3.full_name, value: opponent3}
]
cpu_opponent = opponent_prompt.select("Choose your opponent:", choices)


