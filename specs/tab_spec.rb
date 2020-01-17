require('minitest/autorun')
require('minitest/reporters')
Minitest::Reporters.use! Minitest::Reporters::SpecReporter.new

require_relative('../room.rb')
require_relative('../song.rb')
require_relative('../tab.rb')
require_relative('../guest.rb')


class TabTest < Minitest::Test

  def setup

    # Bar and tab

    @bar_obj = Bar.new()



    # -----------------------------------------------------------

    # create a song obj that will be added to the room obj:
    @song_obj_room_1 = Song.new("ODB", "shimmy shimmy ya")

    # create a room obj with space for 5 guests, and add a song to it, also include @bar_obj as an argument, we can sell drinks to guests through it's methods and keep track of stock

    @room_obj_1 = Room.new(5, 7.00, @bar_obj)
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
    # Checkin some folk:

    @room_obj_1.check_in_guest(@guest_1)
    @room_obj_1.check_in_guest(@guest_2)


  end


  def test_sell_a_drink_available_guest_has_money()
    @room_obj_1.sell_a_drink_to_guest(@guest_1, "vodka")
    #  money in for bar?
    assert_equal(4.50, @bar_obj.check_till)
    # money out for guest?
    assert_equal(15.50, @guest_1.check_wallet)
    # stock reduced?
    assert_equal(99, @bar_obj.check_stock("vodka"))
  end


  def test_sell_a_drink_available_guest_no_money()

    @guest_no_money = Guest.new("Peter", 1.50, @guest_3_fav_song)

    assert_equal("Sorry, but you can't afford it.", @room_obj_1.sell_a_drink_to_guest(@guest_no_money, "vodka"))
    #  money in for bar?
    assert_equal(0.00, @bar_obj.check_till)
    # money out for guest?
    assert_equal(1.50, @guest_no_money.check_wallet)
    # stock reduced?
    assert_equal(100, @bar_obj.check_stock("vodka"))
  end

end
