require('minitest/autorun')
require('minitest/reporters')
Minitest::Reporters.use! Minitest::Reporters::SpecReporter.new

require_relative('../room.rb')
require_relative('../song.rb')
require_relative('../tab.rb')
require_relative('../guest.rb')


class GuestTest < Minitest::Test

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

  end

  def test_cheers_if_fav_song_is_on_checkin
    # room_obj_1 was set up to play ODB - shimmy shimmy ya
    # lets check in the guest_3, whose fav song is exactly
    # that, we except him to cheer right after the checkin.
    assert_equal("Yeeeeeeeeeeee!!! Thats my fav!!!", @room_obj_1.check_in_guest(@guest_3))

    assert_nil(@room_obj_1.check_in_guest(@guest_1))
    assert_nil(@room_obj_1.check_in_guest(@guest_2))

  end

  def test_cheers_if_fav_song_after_checkin
    # room_obj_1 was set up to play ODB - shimmy shimmy ya
    # lets check in guests 1-3, guest_3 should cheer right
    # after checkin as his fav is on, while 1 and 2 should
    # not react at all:

    @room_obj_1.check_in_guest(@guest_1)
    @room_obj_1.check_in_guest(@guest_2)

    assert_equal("Yeeeeeeeeeeee!!! Thats my fav!!!", @room_obj_1.check_in_guest(@guest_3))

    # then the room changes a song to "MF DOOM - Doomsday" which
    # is guest 2's fav, we expect a cheer rigth after song changes

    assert_equal("Yeeeeeeeeeeee!!! Thats my fav!!!", @room_obj_1.change_song(@guest_2_fav_song))

  end


  def test_cheers_if_fav_song_after_checkin_multiple_cheers
    # room_obj_1 was set up to play ODB - shimmy shimmy ya
    # lets check in guests 1-2, there should be no reaction
    @room_obj_1.check_in_guest(@guest_1)
    @room_obj_1.check_in_guest(@guest_2)

    # also lets create and check in a @guest_7 obj, whose favorite song is the same as @guest's 2.
    guest_7 = Guest.new("Dan", 95.00, @guest_2_fav_song)
    @room_obj_1.check_in_guest(guest_7)

    # then the room changes a song to "MF DOOM - Doomsday" which
    # is guest 2's fav and guest 7's, we expect a cheer rigth after song changes from both.

    assert_equal(@guest_2.cheer ,@room_obj_1.change_song(@guest_2_fav_song))

    assert_equal(guest_7.cheer ,@room_obj_1.change_song(@guest_2_fav_song))
  end


end
