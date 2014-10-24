require "csv"

class JukeBox
  attr_reader :database, :query, :songs

  def initialize
    @database = []
    @songs = []
  end

  def load(music_library)
    CSV.foreach(music_library, headers:true) do |row|
      database << row
    end
  end

  def play
    print_welcome
    loop do
      get_query_or_exit
      print_artist_header
      collect_songs_by_artist
      sort_and_print_songs
    end
  end

  private

  def print_welcome
    puts "Welcome to the jukebox! Please select an artist."
  end

  def get_query_or_exit
    loop do
      puts
      print "Query:  "
      @query = gets.chomp

      if query == ""
        puts
        puts "Goodbye!"
        exit
      end

      if (database.find {|row| row["Artist"] == query}).nil? == true
        puts "No songs by that artist on file!"
      else
        break
      end
    end
  end

  def print_artist_header
    header = "* Songs by #{query} *"
    border = "*" * (header.length)

    puts
    puts border
    puts header
    puts border
  end

  def collect_songs_by_artist
    database.each do |row|
      if row["Artist"] == query
        songs << row["Name"]
      end
    end
  end

  def sort_and_print_songs
    alphabetical_songs = songs.sort
    puts alphabetical_songs
  end
end



jukebox = JukeBox.new
jukebox.load("music.csv")
jukebox.play