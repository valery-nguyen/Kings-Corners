require "byebug"

class Player
  attr_reader :name
  attr_accessor :hand

  def initialize(name, deck)
    @name = name
    @hand = Hand.deal_from(deck)
  end

  def play_hand(board)
    until won? || hand.next_move?(board) == false
      self.hand.play(board)
      system("clear")
      board.render
      sleep(2)
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

end
