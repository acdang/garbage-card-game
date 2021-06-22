class Player < ActiveRecord::Base
    has_many :play_rounds
    has_many :rounds, through: :play_rounds

    # display button: "Sign up"
    # or something like "Press enter to sign up"

    # want to get first and last name from user and create new Player instance with name
    # class method for now...
    def self.new_player
        puts "Enter your first name:"
        f_name = STDIN.gets.chomp # doesn't work
        puts "Enter your last name:"
        l_name = STDIN.gets.chomp

        puts "Hello, #{first_name} #{last_name}"

        # Player.create(first_name: f_name, last_name: Faker::Name.l_name, is_cpu: false)
    end

    # "Press enter to start game"
end
