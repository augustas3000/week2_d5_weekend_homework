require('minitest/autorun')
require('minitest/reporters')
Minitest::Reporters.use! Minitest::Reporters::SpecReporter.new

require_relative('../room.rb')
require_relative('../song.rb')
require_relative('../tab.rb')
require_relative('../guest.rb')


class TabTest < Minitest::Test

  def setup
    # create a song obj that will be added to the room obj:
    @song_obj_room_1 = Song.new("ODB", "shimmy shimmy ya")

    # create a room obj with space for 5 guests, and add a song to it.
    @room_obj_1 = Room.new(5, 7)
    @room_obj_1.change_song(@song_obj_room_1)

    # create six guests, with name, wallet, and fav song obj.
    # one guest more that room's capacity of 5 for checking if
    # too full.
    @guest_1_fav_song = Song.new("Drake", "God's plan")
    @guest_1 = Guest.new("Steve", 20.00, @guest_1_fav_song)

    @guest_2_fav_song = Song.new("MF DOOM", "Doomsday")
    @guest_2 = Guest.new("Anna", 35.00, @guest_2_fav_song)

    # guest 3 will have fav song which is the same as the one
    # played in room_obj_1, this is for shoutout later on
    @guest_3_fav_song = @song_obj_room_1
    @guest_3 = Guest.new("Peter", 16.00, @guest_3_fav_song)

    @guest_4_fav_song = Song.new("Craig David", "Fill me in")
    @guest_4 = Guest.new("Desmond", 39.00, @guest_4_fav_song)

    @guest_5_fav_song = Song.new("Cousin Stizz", "No Bells")
    @guest_5 = Guest.new("Mosses", 16.00, @guest_5_fav_song)

    @guest_6_fav_song = Song.new("LTJ Bukem", "Atlantis")
    @guest_6 = Guest.new("Dasy", 10.00, @guest_6_fav_song)

    # -----------------------------------------------------------
    # drinks, tabs etc ....

    @room_obj_1.check_in_guest(@guest_1)
    @room_obj_1.check_in_guest(@guest_2)

  end

end
