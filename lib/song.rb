class Song
  attr_accessor :name
  attr_reader :artist, :genre
  @@all = []

  def initialize(name, artist=nil, genre=nil)
    @name = name
    self.artist = artist if artist != nil
    self.genre = genre if genre != nil
  end

  def self.all
    @@all
  end

  def self.destroy_all
    self.all.clear
  end

  def save
    @@all << self
  end

  def self.create(name)
    new_song = self.new(name)
    new_song.save
    new_song
  end

  def artist=(artist)
    @artist = artist
    self.artist.add_song(self)
  end

  def genre=(genre)
    @genre = genre
    self.genre.add_song(self)
  end

  def self.find_by_name(name)
    self.all.find {|song| song.name == name}
  end

  def self.find_or_create_by_name(name)
    if self.find_by_name(name) == nil
      self.create(name)
    else
      self.find_by_name(name)
    end
  end

  def self.new_from_filename(filename)
    parts = filename.gsub(/(\.mp3)/,'')
    parts = parts.split(" - ")
    artist = Artist.find_or_create_by_name(parts[1])
    genre = Genre.find_or_create_by_name(parts[2])
    song = Song.find_or_create_by_name(parts[0])
    song.artist = artist
    song.genre = genre
  end
end
