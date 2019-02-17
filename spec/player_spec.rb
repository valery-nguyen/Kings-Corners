require 'player'
require 'hand'

describe Player do
  let(:deck) { double("deck") }
  let(:card1) { double("card") }
  let(:card2) { double("card") }
  let(:card3) { double("card") }
  subject(:player) do
    allow(deck).to receive(:take).with(7).and_return([card1, card2])
    Player.new("Valery", deck)
  end

  it "assigns the name" do
    expect(player.name).to eq("Valery")
  end

  describe "#play_hand" do
    let(:board) { double("board")}
    let(:deck) { double("deck")}
    it "renders the board after performing a move" do
      allow(player).to receive(:won?).and_return(false)
      allow(player).to receive_message_chain("hand.next_move?").with(board).and_return(true, false)
      allow(player).to receive_message_chain("hand.play").with(board)
      allow(board).to receive(:deck).and_return(deck)
      allow(player).to receive_message_chain("hand.hit").with(board.deck)
      expect(board).to receive(:render)
      player.play_hand(board)
    end
  end

  describe "#won?" do
    it "returns true when player hand is empty" do
      allow(player).to receive_message_chain("hand.cards.empty?").and_return(true)
      expect(player.won?).to eq(true)
    end

    it "returns false when player still has cards in hand" do
      allow(player).to receive_message_chain("hand.cards.empty?").and_return(false)
      expect(player.won?).to eq(false)
    end
  end

  describe "#update_points" do
    let(:player1) do
      allow(deck).to receive(:take).with(7).and_return([card1])
      Player.new("Valery", deck)
    end
    let(:player2) do
      allow(deck).to receive(:take).with(7).and_return([card1, card2])
      Player.new("Valery", deck)
    end
    it "adds -10 points when a king in inside the hand" do
      allow(card1).to receive(:rank).and_return(13)
      expect(player1.update_points).to eq(-10)
    end

    it "adds -1 points when not a king in inside the hand" do
      allow(card1).to receive(:rank).and_return(5)
      expect(player1.update_points).to eq(-1)
    end

    it "adds penalty for all cards inside the hand" do
      allow(card1).to receive(:rank).and_return(13)
      allow(card2).to receive(:rank).and_return(5)
      expect(player2.update_points).to eq(-11)
    end
  end


end
