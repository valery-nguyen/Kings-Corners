require 'card'
require 'hand'
require 'deck'

describe Hand do
  let(:deck_cards) do
    deck_cards = [
        Card.new(:spades, :deuce),
        Card.new(:spades, :three), 
        Card.new(:spades, :four)
    ]
  end
  subject(:hand) { Hand.new(deck_cards) }
  let(:deck) do
    [
      Card.new(:hearts, :deuce),
      Card.new(:hearts, :three), 
      Card.new(:hearts, :four),
      Card.new(:hearts, :five),
      Card.new(:diamonds, :six),
      Card.new(:diamonds, :seven),
      Card.new(:diamonds, :eight)
    ]

  end

  describe "::deal_from" do
    it "deals a hand of seven cards" do
      deck_cards = [
        Card.new(:spades, :deuce),
        Card.new(:spades, :three), 
        Card.new(:spades, :four),
        Card.new(:spades, :five),
        Card.new(:spades, :six),
        Card.new(:spades, :seven),
        Card.new(:spades, :eight)
      ]

      deck = double("deck")
      expect(deck).to receive(:take).with(7).and_return(deck_cards)

      hand = Hand.deal_from(deck)

      expect(hand.cards).to match_array(deck_cards)
    end
  end

  describe "#initialize" do
    it "can be initialized with an array of cards" do
      cards = [
        Card.new(:spades, :deuce),
        Card.new(:spades, :three), 
        Card.new(:spades, :four),
      ]
      hand = Hand.new(cards)
      expect(hand.cards.length).to eq(3)
    end
  end

  describe "#play" do
    let(:pileA) { double("pile") }
    let(:pileB) { double("pile") }
    let(:card) { double("card") }
    let(:board1) { double("board", :piles => [pileA, pileB])}

    it "performs the pile move correctly" do
      allow(pileA).to receive(:valid_move_onto?).with(pileB).and_return(true)
      allow(pileA).to receive(:remove).and_return([card])
      expect(pileB).to receive(:receive).with([card])
      hand.play(board1)
    end

    it "performs the card move correctly" do
      allow(pileA).to receive(:valid_move_onto?).with(pileB).and_return(false)
      allow(pileB).to receive(:valid_move_onto?).with(pileA).and_return(false)
      allow(hand).to receive(:cards).and_return([card])
      allow(pileA).to receive(:valid_card_play?).with(card).and_return(false)
      allow(pileB).to receive(:valid_card_play?).with(card).and_return(true)

      expect(pileB).to receive(:play).with(card).once
      hand.play(board1)
    end
  end

  describe "#next_move?" do
    let(:pileA) { double("pile") }
    let(:pileB) { double("pile") }
    let(:card) { double("card") }
    let(:board1) { double("board", :piles => [pileA, pileB])}

    it "checks for possible pile move" do
      allow(pileA).to receive(:valid_move_onto?).with(pileB).and_return(true)
      expect(hand.next_move?(board1)).to eq(true)
    end

    it "checks for possible card move" do
      allow(pileA).to receive(:valid_move_onto?).with(pileB).and_return(false)
      allow(pileB).to receive(:valid_move_onto?).with(pileA).and_return(false)
      allow(hand).to receive(:cards).and_return([card])
      allow(pileA).to receive(:valid_card_play?).with(card).and_return(false)
      allow(pileB).to receive(:valid_card_play?).with(card).and_return(true)
      expect(hand.next_move?(board1)).to eq(true)
    end
  end

  describe "#hit" do
  let(:deck) { double("deck") }
  let(:card) { Card.new(:hearts, :deuce) }
    it "hits once at the end of turn" do
      allow(deck).to receive(:take).with(1).and_return([card])
      expect(hand.hit(deck).last).to eq(card)
    end
  end


  describe "#return_cards" do
    let(:deck) { double("deck") }
    let(:hand) do
      Hand.new([Card.new(:spades, :deuce), Card.new(:spades, :three)])
    end

    it "returns cards to deck" do
      expect(deck).to receive(:return) do |cards|
        expect(cards.count).to eq(2)
      end

      hand.return_cards(deck)
    end

    it "removes card from hand" do
      allow(deck).to receive(:return)

      hand.return_cards(deck)
      expect(hand.cards).to eq([])
    end
  end
end
