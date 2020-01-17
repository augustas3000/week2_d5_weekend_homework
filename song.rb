

class Song
  attr_reader :artist_name, :song_name
  def initialize(artist_name_str, song_name_str)
    @artist_name = artist_name_str
    @song_name = song_name_str
  end

end
