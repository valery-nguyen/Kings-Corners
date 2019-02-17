require "byebug"

class Player
  attr_reader :name
  attr_accessor :hand, :points

  def initialize(name, deck)
    @name = name
    @hand = Hand.deal_from(deck)
    @points = 0
  end

  def play_hand(board)
    until won? || hand.next_move?(board) == false
      self.hand.play(board)
      board.render
    end

    if !won?
      self.hand.hit(board.deck)
    end
  end

  def won?
    if hand.cards.empty?
      return true
    end
    false
  end

  def return_cards(deck)
    hand.return_cards(deck)
    hand = nil
  end

  def update_points
    self.hand.cards.each do |card|
      case card.rank
      when 13
        @points -= 10
      else
        @points -= 1
      end
    end
    points
  end

  def display_points
    puts "#{self.name} has #{self.points} points"
  end
  
end
