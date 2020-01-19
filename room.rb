# require 'pry'

# You have been approached to build software for a Karaoke bar. Specifically, they want you to build a software for checking guests in and out, plus handling songs.
#
# Your program should be test driven and should be able to:
#
# Create rooms, songs and guests
# Check in guests to rooms/Check out guests from rooms
# Add songs to rooms

class Room
  attr_reader :song, :entry_fee

  def initialize(space_int, entry_fee_float, bar_obj = nil)

    @entry_fee = entry_fee_float
    # to control room objects capacity:
    @space = space_int

    # there will be an instance method that points the @song instance variable to a chosen song object:
    @song = nil

    # to control room objects capacity: length of guests array will be checked before checking guest objects in, to meke sure it does not go over capacity in integer pointed by @space variable:
    @guests = []

    # event till will track money in from entry fee payed by each guest
    @event_till = 0.00

    # bar obj is nil by default, if access to bar object is desired
    # we can specify a bar object when initialising the room class
    # and point a @bar instance variable to it. This will enable functionality of Bar class object to sell drinks to guests.
    @bar = bar_obj

    # to expand so rooms can add songs to their playlists(to be done)
    @playlist = []
  end

  # instance method to change songs. later on if we add playlist fiunctionality we can update this method to randomly choose a song from playlist?

  def change_song(song_obj)
    @song = song_obj

    # making sure the guests cheer on their favourite tunes, this should work for cases when some guest objects are checked in the room obj, and the song changes to get a rection to peoples favorite songs:
    for guest_obj in @guests
      # binding.pry
      if guest_obj.fav_song?(@song) == true
        return guest_obj.cheer
      end
    end

  end


  def count_guests
    return @guests.length
  end

  # room object will check in guest objects:
  def check_in_guest(guest_obj)
    # capacity check:
    if @guests.length >= @space
      return "This room is full, wait till somebody leaves."
    # guest obj money check:
    elsif guest_obj.check_wallet > @entry_fee
      # money changes hand
      guest_obj.pay(@entry_fee)
      @event_till += @entry_fee
      # guest checked in
      @guests.push(guest_obj)
      # once guest is checked in, if his favorite song is on in the room, he cheers. Cheer is a guest object instance variable:
      if guest_obj.fav_song?(@song) == true
        guest_obj.cheer
      end
    else
      # return message if guest obj does not have enough noney:
      return "Please come back with more cash, entry is #{@entry_fee}£"
    end
  end

  # simply to remove guest obj from guests array:
  def check_out_guest(guest_obj)
    @guests.delete(guest_obj)
  end

  # wrapper method of room object, to call bar object's sell_a_drink method using guest obj and drink_name_str parameters.
  def sell_a_drink_to_guest(guest_obj, drink_name_str)
    @bar.sell_a_drink(guest_obj, drink_name_str)
  end

  # an instance method to check earnings from either event till
  # bar till, or both: (options for till_str parameter:bar, event, total)
  def check_till(till_str)
    if till_str == "bar"
      return @bar.check_bar_till
    elsif till_str == "event"
      return @event_till
    elsif till_str == "total"
      return @bar.check_bar_till + @event_till
    end
  end

  def report_bar_tab()
  # to return a tab summary of all guest objects that were sold drinks.
    return @bar.report_tab()
  end

end
