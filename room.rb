require 'pry'

# You have been approached to build software for a Karaoke bar. Specifically, they want you to build a software for checking guests in and out, plus handling songs.
#
# Your program should be test driven and should be able to:
#
# Create rooms, songs and guests
# Check in guests to rooms/Check out guests from rooms
# Add songs to rooms

class Room
  attr_reader :song, :entry_fee
  # bar obj is nil by default, if access to bar object is desired
  # we can specify a bar object when initialising the room class
  # and point a @bar instance variable to it. This will enable functionality of Bar class object to sell drinks to guests.
  def initialize(space_int, entry_fee_float, bar_obj = nil)
    @entry_fee = entry_fee_float
    @space = space_int
    @song = nil
    @guests = []

    @bar = bar_obj

    # to expand so we rooms can add songs to their playlists
    @playlist = []
  end

  # rename add song to change song?.. unless playlist is included.
  def change_song(song_obj)
    @song = song_obj

    # making sure the guests cheer on their favourite tunes:
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

  def check_in_guest(guest_obj)
    if @guests.length >= @space
      return "This room is full, wait till somebody leaves."
    elsif guest_obj.check_wallet > @entry_fee
      @guests.push(guest_obj)
      if guest_obj.fav_song?(@song) == true
        guest_obj.cheer
      end
    else
      return "Please come back with more cash, entry is #{@entry_fee}£"
    end
  end

  def check_out_guest(guest_obj)
    @guests.delete(guest_obj)
  end

  def sell_a_drink_to_guest(guest_obj, drink_name_str)
    @bar.sell_a_drink(guest_obj, drink_name_str)
  end 
end
