require_relative 'guest.rb'
require_relative 'room.rb'
require_relative 'song.rb'
require_relative 'tab.rb'

p "Would you like to open a caraoke room? (enter y/n)."

while true
  user_input = gets.chomp.downcase
  if user_input == "y"
    break
  end

  if user_input == "n"
    p "Ok Bye"
    exit
  end
  p "Please answer y - to open a caraoke room or n - to quit"
end

p "Nice. Now how many guests the caraoke room should be able to check in? (enter 1-10)."

number_of_guests = 0
regular_xp_anything_but_numbers = /[^0-9]/

while true
  user_input = gets.chomp.downcase
  # any string that does not have integer numbers inside, will return 0 if to_i is called.
  if user_input == "q"
    p "Ok Bye"
    exit
  end

  if user_input.match?(regular_xp_anything_but_numbers) == true
    p "Wrong answer. Please provide a number 1-10. Or q to quit."
  elsif
    number_of_guests = user_input.to_i
    break
  end
end

entry_fee = (rand(5..10)).to_f
p "Cool. Guests will be charged #{entry_fee}£ for entry"


bar_obj = Bar.new()
room_obj = Room.new(number_of_guests, entry_fee, bar_obj)

# load songs
songs_array  = [{artist_name: "ACDC", song_name: "Thunder"}, {artist_name: "Michael Jackson", song_name: "Beat it"},{artist_name: "Drake", song_name: "God's Plan"}, {artist_name: "Biggie Smalls", song_name: "Ready to die"},{artist_name: "Post Malone", song_name: "White Iverson"}, {artist_name: "ODB", song_name: "Shimmy shimmy ya"}, {artist_name: "VengaBoys", song_name: "Boom Boom"}, {artist_name: "Prince", song_name: "Purple rain"}]





p "The Caraokee room opens and #{number_of_guests} guests are in the que to join the party."

# generating guests?
guest_names_array = ["John", "Hellen", "Stacy", "Steven", "Judy", "Max", "Tom", "Nancy", "Dom", "Jack"]

randomised_guest_names_array = []
randomised_song_names_array = []


counter = number_of_guests


while counter > 0

  random_name = guest_names_array.delete(guest_names_array.sample)
  randomised_guest_names_array.push(random_name)

  # generate a favorite song for each
  randomised_song_names_array.push(songs_array.sample)
  counter -= 1

end


randomised_guest_objects_array =
randomised_guest_names_array.map { |x|
  random_song = randomised_song_names_array.pop
  new_song_class = Song.new(random_song[:artist_name],random_song[:song_name])
  Guest.new(x, rand(15..30).to_f, new_song_class)

}








#
# array.map {|x| }
#
#
#
# while true
#
#   while
#
#
# end










#
# while !user_input.is_a(Integer) && user_input.between?(1, 10)
#   p "Please enter a number 1 to 10."
# end
