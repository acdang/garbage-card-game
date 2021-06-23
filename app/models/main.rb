require_relative "player"
require_relative "play_round"
require_relative "round"

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
    Player.new_player(f_name, l_name) # UNCOMMENT THIS LATER!!!!!!!!
end

# check if Player exists
def check_player
    user_exists = false

    while user_exists == false
        puts "---> LOG IN\n"

        f_name = get_first_name()
        l_name = get_last_name()

        search_player = Player.check_player(f_name, l_name)

        if search_player
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
    search_player
end

def player_status(status)
    # create new Player if yes
    if status == 1
        sign_up()
    # check Player if no
    else
        check_player()
    end
end

def create_round(game_id)
    Round.new_round(game_id)
end

def lost_round(round_id, player_id)
    PlayRound.new_lost_round(round_id, player_id)
end

def won_round(round_id, player_id)
    PlayRound.new_won_round(round_id, player_id)
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

current_player = player_status(status)

# Home stats ======================================================

puts "STATS WILL GO HERE"
puts "\n"

continue = TTY::Prompt.new
continue.keypress("---> Press enter to create a NEW GAME\n", keys: [:return])

# Create new game ======================================================

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

binding.pry

# Create new round ======================================================
round1 = create_round(current_game.id) # how to create for multiple rounds without typing it all out

# ---game play---

# ---game finishes---

# "The winner of this round is #{f_name}"

# Create new PlayRounds ======================================================

# lost_round(round1.id, cpu_opponent.id)
# won_round(round1.id, current_player.id)
binding.pry

def create_game
    Game.new_game
end

def choose_opponent
    opponent_prompt = TTY::Prompt.new

    opponent1 = Player.first
    opponent2 = Player.second
    opponent3 = Player.third

    choices = [
        {name: opponent1.full_name, value: opponent1},
        {name: opponent2.full_name, value: opponent2},
        {name: opponent3.full_name, value: opponent3}
    ]
    opponent_prompt.select("Choose your opponent:", choices)
end

def play_game
    # Create game
    current_game = create_game()

    # Choose opponent
    cpu_opponent = choose_opponent()

    # Create round 1
    round1 = create_round(current_game.id)

    # gameplay

    # PlayRounds


    # Create round 2

    # PlayRounds

    # Create round 3

    # PlayRounds

end