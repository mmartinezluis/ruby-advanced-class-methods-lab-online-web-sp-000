require "pry"
class Song
  attr_accessor :name, :artist_name
  @@all = []

  def self.all
    @@all
  end

  def save
    self.class.all << self

  end

  def self.create
    song= self.new
    song.save
    song
  end

  def self.new_by_name(name)
    song=self.new
    song.name=name
    song
  end

  def self.create_by_name(name)
    song=self.new
    song.name=name
    song.save
    song
  end

  def self.find_by_name(name)
    names_list=@@all.collect {|object| object.name}
    if names_list.include?(name)
      index=names_list.index(name)
      @@all[index]
    end
  end

  def self.find_or_create_by_name(name)
    if !!self.find_by_name(name) == false
      self.create_by_name(name)
    else
      self.find_by_name(name)
    end
  end

  def self.alphabetical
    names_list = @@all.collect {|object| object.name}

    marked_sorted_list = names_list.map.with_index do |name, index|
      "#{name}.#{index}"
    end.sort

    getting_master_indexes = marked_sorted_list.collect {|element| element.split(".")}

    master_indexes = getting_master_indexes.collect {|element| element[1].to_i}

    sorted_objects = master_indexes.collect {|master_index| @@all[master_index]}

  #  sorted_list = @@all.collect {|object| object.name}.sort
  #  sorted_objects= sorted_list.collect {|name| @@all[@@all.index(name)]}
  end

  def self.new_from_filename(filename)

      array= filename.split("-")
      song=self.new
      song.artist_name= array[0].strip
      second_array= array[1].split(".")
      song.name= second_array[0].strip
      song
  end

  def self.create_from_filename(filename)
    array= filename.split("-")
    song=self.new
    song.artist_name= array[0].strip
    second_array= array[1].split(".")
    song.name= second_array[0].strip
    song.save
    song
  end

  def self.destroy_all
    @@all.clear
  end

end
