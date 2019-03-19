require "bundler/inline"

gemfile do
    source "https://rubygems.org"
    gem "pg"
    gem "activerecord"
end

require "active_record"

ActiveRecord::Base.logger = Logger.new(STDOUT)

ActiveRecord::Base.establish_connection(
  adapter: "postgresql",
  database: "safari_vacation"
)

class Animal < ActiveRecord::Base
end

puts "Type 'display_all' to show all the animals we've seen.
Type 'increment' to add 1 on the seen count for the specific species.
Type 'species' to show the details for the specific species.
Type 'spot' to update the last seen location of the animal.
Type 'extinct' to delete all the species in the specific location.
Type 'total' to get the total seen_count of all animals"

loop do
  
  puts "What do you want to do?"
  answer = gets.chomp

  if answer == "display_all"
    p Animal.all
     # get all the animals
     # use "puts" to print details about all the animals
  end

  if answer == "increment"
    puts "Enter the species you are looking for:"
    species = gets.chomp.downcase
    animal = Animal.find_by("species": species)
    animal.seen_count += 1
    animal.save
    puts "#{animal.species} count:#{animal.seen_count}"
  end

  if answer == "species"
    puts "what species are you looking for?"
    species_name = gets.chomp.downcase
    animal = Animal.find_by("species": species_name)
    puts "Found the #{animal.species} in #{animal.last_seen_location} and number of animals is #{animal.seen_count}"
  end

  if answer == "spot"
    puts "what species are you looking for?"
    species_name = gets.chomp.downcase
    puts "send location"
    location = gets.chomp.downcase
    animal = Animal.find_by("species": species_name)
    animal.last_seen_location = location
    animal.save
  end

  if answer == "extinct"
    puts "where do u want to end?"
    extinct_location = gets.chomp.downcase
    animal = Animal.where("last_seen_location": extinct_location).destroy_all
    animal.destroy
  end

  if answer == "total"
    puts Animal.sum("seen_count")
    break
  end

end

# if species_result.nil? 
#   puts "No Record Found"
# else
#   species_result.seen_count += 1
#   species_result.save
#   puts "#{species_result.seen_count}"
# end

 #  if answer == 'increment'
  #   p Animal.seen_count + 1
  #  end
   
  #  if answer == 'species'
  #   p Animal.spacies
  #  end

  #  if answer == 'spot'
  #   p Animal.last_seen_location
  #  end

  #  if answer == 'extinct'
  #   answer = Animal.find_by(last_seen_location: 'sdg')
  #   p Animal.destroy
  #  end

  #  if answer == 'total'
  #   animal = Animal.where({"seen_count" =>totalseen_count})
  #   p Animal.sum
  #  end