#!/usr/bin/env ruby
class Word

  attr_accessor :word, :length

  def initialize
    @word=get_word
    @length=word_length
  end

  def get_word
    dictionary=File.readlines("/usr/share/dict/words").sample
  end

  def word_length
    word.length
  end

end

class Puzzle

  attr_accessor :word, :dashesarray, :requiredscore, :puzzlearray

  def initialize
    @word = Word.new
    @puzzlearray = array
    @dashesarray = dashes
    @requiredscore = puzzlearray.length
  end

  def replace_dashes(guess)
  end

  def dashes
    i=1
    dashes = ""
    arraylength = puzzlearray.length
    while i < arraylength do
      dashes << "-"
      i += 1
    end
    dashesarray = dashes.split("")
  end

  def array
    word.word.split("")
  end

  def print_puzzle
    for i in dashesarray do
      print "#{i}"
    end
    puts ""
  end

end

class Game

  attr_accessor :puzzle, :score, :letter, :lettersguessed

  def initialize
    @puzzle = Puzzle.new
    @score = 0
    @letter = ""
    @lettersguessed = []
    puzzle.print_puzzle
    puts "Enter your guess: "
  end

  def guess
      letter = gets.chomp
      while letter.length > 1 do
        puts "You may only enter one letter"
        letter = gets.chomp
      end
      right_or_wrong(letter)
  end

  def reveal(letternumbers)
    for i in letternumbers do
      puzzle.dashesarray[i] = puzzle.puzzlearray[i]
    end
    puzzle.print_puzzle
  end

  def right_or_wrong(letter)
    unless lettersguessed.include? letter
      already_guessed(letter)
      if puzzle.puzzlearray.include? letter
        puts "You chose wisely"
        p = puzzle.puzzlearray.each_index.select{|i| puzzle.puzzlearray[i] == "#{letter}"}
        reveal(p)
        score =+ 1
      else
        puts "WRONG!"
      end
    else
      puts "You already guessed that!"
    end
  end

  def play
    while puzzle.dashesarray.include? "-" do
      guess
    end
    puts "You win!"
    puts "The word is: #{puzzle.word.word}"
  end

  def already_guessed(letter)
    lettersguessed << letter
  end

end

game = Game.new
game.play