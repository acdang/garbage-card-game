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
    puts "Sign up:\n"

    f_name = get_first_name()
    l_name = get_last_name()

    puts "\n"
    puts "Hello, #{f_name} #{l_name}"
    # Player.new_player(f_name, l_name)
end

# check if Player exists
def check_player
    puts "Log in:\n"

    f_name = get_first_name()
    l_name = get_last_name()

    if Player.check_player(f_name, l_name)
        puts "\n"
        puts "Hello, #{f_name} #{l_name}"
        return true
    else
        puts "\n"
        puts "That user does not exist"
        return false
    end
end

puts "Welcome to Garbage, a card game!"
puts "\n"

new_player = TTY::Prompt.new
new_player.yes?("Are you a new player?") # change to select?

# create new Player if yes
if new_player
    sign_up()
# check Player if no
else
    while !check_player()
        heck_player()
    end
end

# Choose opponent ======================================================

cpu_opponent = TTY::Prompt.new

opponent1 = Player.first
opponent2 = Player.second
opponent3 = Player.third

choices = [
    {name: opponent1.full_name, value: opponent1},
    {name: opponent2.full_name, value: opponent2},
    {name: opponent3.full_name, value: opponent3}
]
cpu_opponent.select("Choose your opponent:", choices)

# ======================================================

