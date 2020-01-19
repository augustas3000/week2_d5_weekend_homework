require('minitest/autorun')
require('minitest/reporters')
Minitest::Reporters.use! Minitest::Reporters::SpecReporter.new

require_relative('../room.rb')
require_relative('../song.rb')
require_relative('../tab.rb')
require_relative('../guest.rb')


class RoomTest < Minitest::Test

  def setup
    # Initiate bar object from Bar class
    @bar_obj = Bar.new()



    # ----------------------------------------------------

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

  end

  def test_add_song
    # ODB - shimmy shimmy ya was added as part of setup so let's
    # check:
    actual_song_full_name = "#{@room_obj_1.song.artist_name} - #{@room_obj_1.song.song_name}"
    assert_equal("ODB - shimmy shimmy ya", actual_song_full_name)
  end

  def test_check_in_guest_space_available
    @room_obj_1.check_in_guest(@guest_1)
    @room_obj_1.check_in_guest(@guest_2)
    @room_obj_1.check_in_guest(@guest_3)
    @room_obj_1.check_in_guest(@guest_4)

    assert_equal(4, @room_obj_1.count_guests)
  end


  def test_check_in_guest_space_NOT_available
    @room_obj_1.check_in_guest(@guest_1)
    @room_obj_1.check_in_guest(@guest_2)
    @room_obj_1.check_in_guest(@guest_3)
    @room_obj_1.check_in_guest(@guest_4)
    @room_obj_1.check_in_guest(@guest_5)
    # if we now try to check in the 6th guest, we expect a mesage
    # that the room is full(5/5).
    assert_equal("This room is full, wait till somebody leaves.", @room_obj_1.check_in_guest(@guest_6))
  end

  def test_check_in_test_not_enough_cash
    # lets suppose guest_1 spends most of his cash and only has 5£ in the wallet:
    @guest_1.pay(15)
    assert_equal("Please come back with more cash, entry is #{@room_obj_1.entry_fee}£",@room_obj_1.check_in_guest(@guest_1))
  end


  def test_check_out_guest
    @room_obj_1.check_in_guest(@guest_1)
    @room_obj_1.check_in_guest(@guest_2)
    # 2 people in the room so we check_out one, and expect one.
    @room_obj_1.check_out_guest(@guest_1)
    assert_equal(1, @room_obj_1.count_guests)
  end

  def test_check_till_bar

    @room_obj_1.check_in_guest(@guest_1)
    @room_obj_1.check_in_guest(@guest_2)
    @room_obj_1.check_in_guest(@guest_3)
    @room_obj_1.check_in_guest(@guest_4)

    @room_obj_1.sell_a_drink_to_guest(@guest_1, "beer")
    @room_obj_1.sell_a_drink_to_guest(@guest_1, "beer")
    @room_obj_1.sell_a_drink_to_guest(@guest_1, "cider")

    @room_obj_1.sell_a_drink_to_guest(@guest_2, "beer")
    @room_obj_1.sell_a_drink_to_guest(@guest_2, "vodka")

    @room_obj_1.sell_a_drink_to_guest(@guest_4, "vodka")
    @room_obj_1.sell_a_drink_to_guest(@guest_4, "cider")

    assert_equal(26.9, @room_obj_1.check_till("bar"))

  end

  def test_check_till_event

    @room_obj_1.check_in_guest(@guest_1)
    @room_obj_1.check_in_guest(@guest_2)
    @room_obj_1.check_in_guest(@guest_3)
    @room_obj_1.check_in_guest(@guest_4)

    @room_obj_1.sell_a_drink_to_guest(@guest_1, "beer")
    @room_obj_1.sell_a_drink_to_guest(@guest_1, "beer")
    @room_obj_1.sell_a_drink_to_guest(@guest_1, "cider")

    @room_obj_1.sell_a_drink_to_guest(@guest_2, "beer")
    @room_obj_1.sell_a_drink_to_guest(@guest_2, "vodka")

    @room_obj_1.sell_a_drink_to_guest(@guest_4, "vodka")
    @room_obj_1.sell_a_drink_to_guest(@guest_4, "cider")

    assert_equal(28, @room_obj_1.check_till("event"))
  end

  def test_check_till_total
    @room_obj_1.check_in_guest(@guest_1)
    @room_obj_1.check_in_guest(@guest_2)
    @room_obj_1.check_in_guest(@guest_3)
    @room_obj_1.check_in_guest(@guest_4)

    @room_obj_1.sell_a_drink_to_guest(@guest_1, "beer")
    @room_obj_1.sell_a_drink_to_guest(@guest_1, "beer")
    @room_obj_1.sell_a_drink_to_guest(@guest_1, "cider")

    @room_obj_1.sell_a_drink_to_guest(@guest_2, "beer")
    @room_obj_1.sell_a_drink_to_guest(@guest_2, "vodka")

    @room_obj_1.sell_a_drink_to_guest(@guest_4, "vodka")
    @room_obj_1.sell_a_drink_to_guest(@guest_4, "cider")

    assert_equal(54.9, @room_obj_1.check_till("total"))
  end

  def test_report_bar_tab
      @room_obj_1.check_in_guest(@guest_1)
      @room_obj_1.check_in_guest(@guest_2)
      @room_obj_1.check_in_guest(@guest_3)
          # ensure guests have enough money for this test
      @guest_1.guest_wallet = 100.00
      @guest_2.guest_wallet = 100.00
      @guest_3.guest_wallet = 100.00

      # guest objs 1-3 were checked in and buy a lot of drinks

      @room_obj_1.sell_a_drink_to_guest(@guest_1, "vodka")
      @room_obj_1.sell_a_drink_to_guest(@guest_1, "vodka")
      @room_obj_1.sell_a_drink_to_guest(@guest_1, "beer")


      @room_obj_1.sell_a_drink_to_guest(@guest_2, "cider")
      @room_obj_1.sell_a_drink_to_guest(@guest_2, "cider")
      @room_obj_1.sell_a_drink_to_guest(@guest_2, "cider")
      @room_obj_1.sell_a_drink_to_guest(@guest_2, "cider")
      @room_obj_1.sell_a_drink_to_guest(@guest_2, "beer")
      @room_obj_1.sell_a_drink_to_guest(@guest_2, "beer")


      @room_obj_1.sell_a_drink_to_guest(@guest_3, "beer")
      @room_obj_1.sell_a_drink_to_guest(@guest_3, "beer")
      @room_obj_1.sell_a_drink_to_guest(@guest_3, "beer")
      @room_obj_1.sell_a_drink_to_guest(@guest_3, "beer")

      # define an expected tab summary in raw hashes:
  expected_tab = {@guest_1 => {name: @guest_1.guest_name,
                   drinks_bought: {"vodka" => 2, "beer" => 1}},
      @guest_2 => {name: @guest_2.guest_name,
                  drinks_bought: {"cider" => 4, "beer" => 2}},
      @guest_3 => {name: @guest_3.guest_name,
                   drinks_bought: {"beer" => 4}}
                }

    assert_equal(expected_tab, @room_obj_1.report_bar_tab)

  end



end
