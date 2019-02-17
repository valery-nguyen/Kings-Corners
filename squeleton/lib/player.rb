require "byebug"

class Player
  attr_reader :name
  attr_accessor :hand, :points

  def initialize(name, deck)
    @hand = Hand.deal_from(deck)
    @points = 0
  end

  def play_hand(board)
    until won? || hand.next_move?(board) == false
      self.hand.play(board)
    end

    if !won?
      self.hand.hit(board.deck)
    end
  end

  def won?
  end

  def return_cards(deck)
    hand.return_cards(deck)
    hand = nil
  end

  def update_points
  end

  def display_points
    puts "#{self.name} has #{self.points} points"
  end
  
end
