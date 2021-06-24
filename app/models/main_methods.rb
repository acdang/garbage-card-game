require_relative "player"
require_relative "play_round"
require_relative "round"
require_relative "player_hand"
require_relative "deck"

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
    # registered = TTY::Prompt.new
    # registered.ok("Hello, #{f_name} #{l_name}!")
    puts "\n"
    Player.new_player(f_name, l_name)
end
# check if Player exists
def check_player
    user_exists = false

    # while user_exists == false
        puts "---> LOG IN\n"

        f_name = get_first_name()
        l_name = get_last_name()

        search_player = Player.check_player(f_name, l_name)

        if search_player
            puts "\n"
            # exist = TTY::Prompt.new
            # exist.ok("Hello, #{f_name} #{l_name}!")
            puts "\n"
            user_exists = true
        else
            puts "\n"
            not_exist = TTY::Prompt.new
            not_exist.error("That user does not exist.")
            puts "\n"

            next_steps_prompt()
        end
    # end
    search_player
end
def player_status(status)
    # create new Player if yes
    if status == 1
        sign_up()
    # check Player if no
    elsif status == 2
        check_player()
    else
        exit
    end
end
def handle_player
    new_player = TTY::Prompt.new
    options = [{name: "New Player", value: 1}, {name: "Returning Player", value: 2}, {name: "quit", value: 3}]
    status = new_player.select("What's your status?", options)
    puts "\n"

    player_status(status)
end
def next_steps_prompt
    next_steps = TTY::Prompt.new
    options = [
        {name: "Try LOG IN again", value: 1},
        {name: "SIGN UP", value: 2},
        {name: "quit", value: 3}
    ]
    choice = next_steps.select("What do you want to do next?", options)

    if choice == 1
        puts "\n"
        check_player()
    elsif choice == 2
        puts "\n"
        sign_up()
    else
        exit
    end
end

def menu_prompt(current_player)
    menu = TTY::Prompt.new
    options = [
        {name: "Start a NEW GAME", value: 1},
        {name: "DELETE account", value: 2},
        {name: "quit", value: 3}
    ]
    choice = menu.select("MENU:", options)

    if choice == 1
        play_game(current_player)
    elsif choice == 2
        delete_account(current_player)
    else
        exit
    end
end

def delete_account#(current_player)
    confirm = TTY::Prompt.new
    choice = confirm.yes?("Are you sure you want to DELETE your account?")

    if choice
        puts "WILL DELETE ACCOUNT"
        puts "\n"
    else
        menu(current_player)
    end
end

def menu(current_player)
    puts "----------------------------"
    hello = TTY::Prompt.new
    hello.ok("Hello, #{current_player.full_name}!")
    puts "\n"

    display_stats(current_player)

    menu_prompt(current_player)

end

def create_round(current_game)
    round = Round.new_round
    current_game.rounds << round
    round
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

def create_play_rounds(round, winning_player, losing_player)
    won_round = PlayRound.new_won_round
    winning_player.play_rounds << won_round
    round.play_rounds << won_round

    lost_round = PlayRound.new_lost_round
    losing_player.play_rounds << lost_round
    round.play_rounds << lost_round
end


def display_stats(current_player)
    #display total number of completed games by player
    puts "Number of completed games: #{current_player.total_num_completed_games}"
    puts "\n"

    # display total num of games won
end

def gameplay(round, current_player, cpu_opponent)
    deck1 = Deck.new
    current_player_hand = PlayerHand.new(deck1, current_player)
    cpu_player_hand = PlayerHand.new(deck1, cpu_opponent)

    while !(current_player_hand.round_won) && !(cpu_player_hand.round_won) do
        current_player_hand.make_move
        cpu_player_hand.make_move
    end

    if current_player_hand.round_won
        winning_player = current_player_hand.player
        losing_player = cpu_player_hand.player
    else
        winning_player = cpu_player_hand.player
        losing_player = current_player_hand.player
    end

    puts "\n"
    puts "The winner of this round is #{winning_player.full_name}."
    puts "\n"
    # PlayRounds
    create_play_rounds(round, winning_player, losing_player)
end


def play_game(current_player)
    # Create game
    current_game = create_game()

    # Choose opponent
    cpu_opponent = choose_opponent()


    # Create round 1
    round1 = create_round(current_game)

    # gameplay + PlayRounds
    gameplay(round1, current_player, cpu_opponent)

    second_round = TTY::Prompt.new
    second_round.keypress("---> Press enter to beging ROUND 2", keys: [:return])

    # Create round 2
    round2 = create_round(current_game)

    # gameplay + PlayRounds
    gameplay(round2, current_player, cpu_opponent)

    third_round = TTY::Prompt.new
    third_round.keypress("---> Press enter to beging ROUND 3", keys: [:return])

    # Create round 3
    round3 = create_round(current_game)

    # gameplay + PlayRounds
    gameplay(round3, current_player, cpu_opponent)

    current_game = current_game.finished
    winner = TTY::Prompt.new
    winner.ok("The winner of this game is #{current_game.get_winner.full_name}!")
    puts "\n"
    # puts "The winner of this game is #{current_game.get_winner.full_name}"

    go_home = TTY::Prompt.new
    go_home.keypress("---> Press enter to go to HOME", keys: [:return])
    menu(current_player)
end
