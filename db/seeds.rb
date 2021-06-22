Player.destroy_all

# CREATING CPU PLAYERS

puts "Creating CPU players..."

3.times do
    Player.create(first_name: Faker::Name.first_name, last_name: Faker::Name.last_name, is_cpu: true)
end
