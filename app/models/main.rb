require_relative "player"

require "tty-prompt"

prompt = TTY::Prompt.new

# creates new Player with user input name
def sign_up
    puts "Enter your first name:"
    f_name = STDIN.gets.chomp
    puts "Enter your last name:"
    l_name = STDIN.gets.chomp

    puts "\n"
    puts "Hello, #{f_name} #{l_name}"
    Player.new_player(f_name, l_name)
end

# check if Player exists
def check_player
    puts "Enter your first name:"
    f_name = STDIN.gets.chomp
    puts "Enter your last name:"
    l_name = STDIN.gets.chomp

    if Player.check_player(f_name, l_name)
        puts "\n"
        puts "Hello, #{f_name} #{l_name}"
    else
        puts "\n"
        puts "User does not exist"
    end
end

puts "Welcome to Garbage, a card game!"
puts "\n"

# puts "Would you like to know the rules? ('yes' or 'no')"

    # puts "Are you a new player? 'yes' or 'no')"
    # new_player = STDIN.gets.chomp

new_player = prompt.yes?("Are you a new player?")

# create new Player if yes
if new_player
    puts "\n"
    puts "You are a new player!"

    sign_up()
# check Player if no
elsif !new_player
    puts "\n"
    puts "You are not a new player."

    check_player()
else
    puts "\n"
    puts "Not a valid response."
end

# DISPLAY STATS HERE

