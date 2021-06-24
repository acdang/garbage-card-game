require "tty-prompt"
require 'pry'

class PlayerHand

    attr_accessor :cards, :deck, :round_won, :player

    def initialize(deck, player)
        @deck = deck
        @cards = []
        @player = player
        10.times do 
            @cards.append(deck.remove_card)
        end
        # deck.players << self
        @round_won = false
    end
    
    def make_move

        puts "\nIt is #{@player.full_name}'s turn.\n\n".light_blue

        card = deck.remove_card

        while card do

            spots = empty_spots
            print_spots(spots)

            card %= 13

            if card == 0

                if !(@player.is_cpu)

                    prompt = TTY::Prompt.new

                    location = prompt.select("You pulled a " + "W".light_red + "I".light_yellow + "L".light_green + "D ".light_blue + "card! Choose an empty spot to fill with your " + "W".light_red + "I".light_yellow + "L".light_green + "D ".light_blue + "card:", spots)
                    
                    print "\n"

                    card = swap_cards(location)
                    
                    if complete_hand?(@cards)
                        win
                        return true
                    end

                else

                    i = spots.sample
                    card = @cards[i - 1]
                    @cards[i - 1] = nil

                    puts "#{@player.full_name} pulled a " + "W".light_red + "I".light_yellow + "L".light_green + "D ".light_blue + "card! #{@player.full_name} fills a #{i} with their " + "W".light_red + "I".light_yellow + "L".light_green + "D ".light_blue + "card.\n\n"

                    sleep(2.1)

                    if complete_hand?(@cards)
                        win
                        return true
                    end
                end

            elsif card == 11 || card == 12

                garbage_card_prompt(card)
                return true

            else

                replace_card_prompt(card)
                
                temp = card

                card = swap_cards(card)

                if card == nil
                    already_played_prompt(temp)
                end

                if complete_hand?(@cards)
                    win
                    return true
                end

            end

        end

    end

    private

    def swap_cards(new)
        temp = @cards[new - 1]
        @cards[new - 1] = nil
        new = temp
        return new
    end

    def replace_card_prompt(card)
        if @player.is_cpu
            puts "---> #{@player.full_name} pulled a " + "#{card}".red + "! #{@player.full_name} plays their " + "#{card}".red + ".\n\n"
            sleep(2.1)
        else
            continue = TTY::Prompt.new
            continue.keypress("---> You pulled a " + "#{card}".red + "! Press enter to play your card.\n", keys: [:return])
        end
    end

    def garbage_card_prompt(card)
        if card == 11
            card = "jack"
        else
            card = "queen"
        end

        if @player.is_cpu
            puts "---> #{@player.full_name} pulled a " + "#{card}".light_red + ", which is a garbage card. Their turn ends.\n\n"
            sleep(2.1)
        else
            continue = TTY::Prompt.new
            continue.keypress("---> You pulled a " + "#{card}".light_red + ", which is a garbage card. Press enter to end your turn.\n", keys: [:return])
        end
    end

    def already_played_prompt(card)
        if @player.is_cpu
            puts "#{@player.full_name} has already played this " + "#{card}".light_red + ". Their turn ends.\n\n"
            sleep(2.1)
        else
            continue = TTY::Prompt.new
            continue.keypress("You have already played a " + "#{card}".light_red + ". Press enter to end your turn.\n", keys: [:return])
        end
    end
    
    def empty_spots
        i = 0
        empty_spots = []
        while i < 10 do
            if @cards[i] != nil
                empty_spots << i + 1
            end
            i += 1
        end
        empty_spots
    end

    def print_spots(empty)
        if @player.is_cpu
            print "#{@player.full_name} draws a card. Here are #{@player.full_name}'s empty spots: "
        else
            print "You draw a card. These are your empty spots: "
        end

        len = empty.length
        if len > 2
            i = 1
            while i < len
                print "#{empty[i - 1]}".green + ", "
                i += 1
            end
            print "and " + "#{empty[len - 1]}\n\n".green
        elsif len == 2
            print "#{empty[0]} ".green + "and " + "#{empty[1]}\n\n".green
        else
            print "#{empty[0]}\n\n".green
        end
    end

    def complete_hand?(array)
        array.uniq.size <= 1
    end

    def win
        @round_won = true
        if @player.is_cpu
            puts "#{@player.full_name} won the round!\n".light_blue
        else
            puts "You won the round!\n".light_blue
        end
    end

end
