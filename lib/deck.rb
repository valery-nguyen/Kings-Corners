# Represents a deck of playing cards.
class Deck
  # Returns an array of all 52 playing cards.
  def self.all_cards
    arr = []
    Card.suits.each do |suit|
      Card.values.each do |value|
        arr << Card.new(suit, value)
      end
    end
    arr.shuffle
  end

  def initialize(cards = Deck.all_cards)
    @cards = cards
  end

  # Returns the number of cards in the deck.
  def count
    @cards.length
  end

  # Takes `n` cards from the top of the deck.
  def take(n)
    if n > self.count
      return [] #deck is empty
    else
      cards.shift(n)
    end
  end

  # Returns an array of cards to the bottom of the deck.
  def return(cards)
    @cards += cards
  end

  protected
  attr_accessor :cards
end
