require "byebug"

class Hand
  attr_accessor :cards

  # This is a *factory method* that creates and returns a `Hand`
  # object.
  def self.deal_from(deck)
  end

  def initialize(cards)
  end

  def next_move?(board)
    # return true if there is a possible pile move

    # return true if there is a possible card move

  end

  def play(board)
    # check and perform pile move

    # check and perform card move


  end

  def hit(deck)
  end

  def return_cards(deck)
  end

end
