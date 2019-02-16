require "byebug"

class Hand
  attr_accessor :cards

  # This is a *factory method* that creates and returns a `Hand`
  # object.
  def self.deal_from(deck)
    Hand.new(deck.take(7))
  end

  def initialize(cards)
    @cards = cards
  end

  def play(board)
    # check for possible pile move
    board.piles.each do |pile1|
      board.piles.each do |pile2|
        if pile1 != pile2 && pile1.valid_move_onto?(pile2)
          pile2.receive(pile1.remove)
          return true
        end
      end
    end

    # check for possible card move
    cards.each do |card|
      board.piles.each do |pile|
        if pile.valid_card_play?(card)
          pile.play(card)
          self.cards.delete(card)
          return true
        end
      end
    end

    false
  end

  def next_move?(board)
    # check for possible pile move
    board.piles.each do |pile1|
      board.piles.each do |pile2|
        if pile1 != pile2 && pile1.valid_move_onto?(pile2)
          return true
        end
      end
    end

    # check for possible card move
    cards.each do |card|
      board.piles.each do |pile|
        return true if pile.valid_card_play?(card)
      end
    end

    false
  end

  def hit(deck)
    self.cards += deck.take(1)
  end

  def return_cards(deck)
    deck.return(@cards)
    self.cards = []
  end

end
