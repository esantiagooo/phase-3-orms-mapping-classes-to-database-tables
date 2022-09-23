class Song

  attr_accessor :name, :album, :id

  def initialize(name:, album:, id: nil)
    @id = id
    @name = name
    @album = album
  end
  # creates a new song instances

  def self.create_table
    sql =  <<-SQL
      CREATE TABLE IF NOT EXISTS songs (
        id INTEGER PRIMARY KEY,
        name TEXT,
        album TEXT
      )
      SQL
      DB[:conn].execute(sql)
  end
  # creates a SQL table with column names that match the initialize attributes

  def save 
    sql = <<-SQL
    INSERT INTO songs (name, album)
    VALUES (?,?)
    SQL
    DB[:conn].execute(sql, self.name, self.album)
    # creates a new row in the table for song instances and saves attributes into database

    self.id = DB[:conn].execute('SELECT last_insert_rowid() FROM songs')[0][0]
    # grabs the song's ID from the database and saves it to ruby instance

    self
  end 

  def self.create(name:, album:)
    song = Song.new(name: name, album: album)
    song.save
  end
  end

