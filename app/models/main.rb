require_relative "player"

require "tty-prompt"

prompt = TTY::Prompt.new

# creates new Player with user input name

def get_first_name
    prompt = TTY::Prompt.new
    puts "\n"
    prompt.ask("Enter your FIRST name:") do |q|
        q.required  true
        q.validate  /\A\w+\Z/
        q.modify    :capitalize
    end
end

def get_last_name
    prompt = TTY::Prompt.new

    prompt.ask("Enter your LAST name:") do |q|
        q.required  true
        q.validate  /\A\w+\Z/
        q.modify    :capitalize
    end
end

def sign_up
    f_name = get_first_name()
    l_name = get_last_name()

    puts "\n"
    puts "Hello, #{f_name} #{l_name}"
    # Player.new_player(f_name, l_name)
end

# check if Player exists
def check_player
    f_name = get_first_name()
    l_name = get_last_name()
    
    user_exists = false

    if Player.check_player(f_name, l_name)
        puts "\n"
        puts "Hello, #{f_name} #{l_name}"
        user_exists = true
    else
        puts "\n"
        puts "That user does not exist"
        user_exists
    end
end

puts "Welcome to Garbage, a card game!"
puts "\n"

new_player = prompt.yes?("Are you a new player?")

# create new Player if yes
if new_player
    sign_up()
# check Player if no
else
    loop do
        check_player()
    break if check_player()
    end
end

# DISPLAY STATS HERE

# "Choose your opponent by entering their number"
# 1. Opponent 1
# 2. Opponent 2
# 3. Opponent 3
# [save this opponent to variable]
