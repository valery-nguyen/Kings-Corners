require 'card'

describe Card do
  
  let(:suit1) { :hearts }
  let(:suit2) { :spades }
  let(:value1) { :jack }
  let(:value2) { :five }
  let(:card1) { Card.new(suit1, value1)}
  let(:card2) { Card.new(suit2, value2)}
  subject(:card) { Card.new(suit1, value1)}

  describe "#initialize" do
    it "can be initialized with a suit and a value" do
      expect(card.suit).to eq(:hearts)
      expect(card.value).to eq(:jack)
    end
  end

  describe "#color" do
    it "returns the color of the card" do
      expect(card1.color).to eq("red")
      expect(card2.color).to eq("black")
    end
  end

  describe "#rank" do
    it "returns the rank of the card" do
      expect(card1.rank).to eq(11)
      expect(card2.rank).to eq(5)
      expect(card1.rank).to be_a(Integer)
    end
  end
end