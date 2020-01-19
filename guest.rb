

class Guest
  attr_reader :guest_name
  # delete this afetr test:
  attr_accessor :guest_wallet

  def initialize(guest_name_str, guest_wallet_float, guest_fav_song_obj)
    @guest_name = guest_name_str
    @guest_wallet = guest_wallet_float
    @guest_fav_song = guest_fav_song_obj
  end

  def check_wallet
    return @guest_wallet
  end

  def pay(price_float)
    @guest_wallet -= price_float
  end

  def fav_song?(song_obj)
    if @guest_fav_song == song_obj
      return true
    end
  end

  def cheer
    return "Yeeeeeeeeeeee!!! Thats my fav!!!"
  end



end

# Guests could have a favourite song, and if their favourite song is on the room’s playlist, they can cheer loudly! (return a string like “Whoo!”)
