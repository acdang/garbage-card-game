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
    # Player.new_player(f_name, l_name) # UNCOMMENT THIS LATER!!!!!!!!
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

def handle_player
    new_player = TTY::Prompt.new
    options = [{name: "New Player", value: 1}, {name: "Returning Player", value: 2}]
    status = new_player.select("What's your status?", options)
    puts "\n"

    player_status(status)
end

def create_round(current_game)
    current_game.rounds << Round.new_round
end

def lost_round(round_id, player_id)
    PlayRound.new_lost_round(round_id, player_id)
end

def won_round(round_id, player_id)
    PlayRound.new_won_round(round_id, player_id)
end

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

def create_play_rounds(round_id, winner_player_id, loser_player_id)
    Player.find(winner_player_id).play_rounds << won_round(round_id, winner_player_id)
    Player.find(loser_player_id).play_rounds << lost_round(round_id, loser_player_id)
end

def play_game
    # Create game
    current_game = create_game()

    # Choose opponent
    cpu_opponent = choose_opponent()

    # Create round 1
    round1 = create_round(current_game)

    # gameplay

    # PlayRounds
    # create_play_rounds(round1.id, [winner_player_id], [loser_player_id])

    # Create round 2
    round2 = create_round(current_game)

    # gameplay

    # PlayRounds
    # create_play_rounds(round2.id, [winner_player_id], [loser_player_id])

    # Create round 3
    round3 = create_round(current_game)

    # gameplay

    # PlayRounds
    # create_play_rounds(round3.id, [winner_player_id], [loser_player_id])

end

# methods should prob be in another file?



# ==============================================================
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
