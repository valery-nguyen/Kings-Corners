require 'pile'
require 'card'

describe Pile do
  let(:top_card) { Card.new(:clubs, :king) }
  subject(:foundation_pile) { Pile.new([top_card]) }
  let(:corner_pile) { Pile.new }
  
  describe '#initialize' do
    it 'correctly initializes a foundation pile with a top card' do
      expect(foundation_pile.seq.first).to eq(top_card)
      
    end

    it 'correctly initialize a corner pile' do
        expect(corner_pile.seq).to be_empty
    end
  end

  describe '#top_color' do
    it 'returns the top card color' do
      expect(foundation_pile.top_color).to eq(top_card.color)
    end
  end

  describe '#top_rank' do
    it 'returns the top card rank' do
      expect(foundation_pile.top_rank).to eq(top_card.rank)
    end
  end

  let(:new_pile) do
    new_pile = Pile.new([top_card])
    new_pile.seq.unshift(Card.new(:clubs, :deuce))
    new_pile.seq.unshift(Card.new(:diamonds, :three))
    new_pile
  end

  describe '#bottom_color' do
    it 'returns the bottom card color' do

      expect(new_pile.bottom_color).to eq("black")
    end
  end

  describe '#bottom_rank' do
    it 'returns the bottom card rank' do
      expect(new_pile.bottom_rank).to eq(13)
    end
  end

  describe '#foundation?' do
    it 'returns true if pile is a foundation pile' do
      expect(foundation_pile.foundation?).to eq(true)
      expect(corner_pile.foundation?).to eq(false)
    end
  end

  describe '#corner?' do
    it 'returns true if pile is a corner pile' do
      expect(foundation_pile.corner?).to eq(false)
      expect(corner_pile.corner?).to eq(true)
    end
  end

  describe '#empty?' do
    it 'returns true if pile is empty' do
      expect(foundation_pile.corner?).to eq(false)
      expect(corner_pile.corner?).to eq(true)
    end
  end

  describe '#remove' do
    it 'empties the pile' do
      foundation_pile.remove
      expect(foundation_pile.seq).to be_empty
    end
  end

  describe '#receive' do
    let(:incoming_cards) { [top_card]}
    let(:seq) { [] }
    it 'received another pile of cards' do
      allow(incoming_cards).to receive(:concat).with(seq).and_return([top_card])    
      corner_pile.receive(incoming_cards)
      expect(corner_pile.seq.length).to eq(1)
    end
  end

  describe '#show' do
    it 'returns the sequence of cards in pile' do
      expect(foundation_pile.show.length).to eq(1)
    end
  end

  describe '#valid_card_play?' do
    it 'approves playing a card of the lower rank and different color' do
      played_card = Card.new(:hearts, :queen)
      expect(foundation_pile.valid_card_play?(played_card)).to eq(true)
    end

    it 'rejects a same color card' do
      played_card = Card.new(:spades, :queen)
      expect(foundation_pile.valid_card_play?(played_card)).to eq(false)
    end

    it 'rejects a same or higher rank card' do
      played_card = Card.new(:hearts, :king)
      expect(foundation_pile.valid_card_play?(played_card)).to eq(false)
    end
  end

  describe '#valid_move_onto?' do
    it 'approves playing pile onto another pile' do
        expect(foundation_pile.valid_move_onto?(corner_pile)).to eq(true)  
      
    end

    it 'rejects playing pile onto another pile' do
      expect(corner_pile.valid_move_onto?(foundation_pile)).to eq(false)
    end
  end

  describe '#play' do
    it 'puts a card on top of a pile' do
      played_card = Card.new(:hearts, :queen)
      foundation_pile.play(played_card)
      expect(foundation_pile.top_color).to eq("red")
      expect(foundation_pile.top_rank).to eq(12)
    end

    it 'rejects an invalid play' do
      expect do
        played_card = Card.new(:diamonds, :eight)
        corner_pile.play(played_card)
      end.to raise_error('invalid card play')
    end
  end

end
