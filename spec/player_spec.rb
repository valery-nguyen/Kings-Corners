require 'player'

describe Player do
  subject(:player) do
    Player.new("Nick the Greek")
  end

  it "assigns the name" do
    expect(player.name).to eq("Nick the Greek")
  end

  describe "#return_cards" do
    let(:deck) { double("deck") }
    let(:hand) { double("hand", :return_cards => nil) }

    before(:each) { player.hand = hand }

    it "returns player's cards to the deck" do
      expect(hand).to receive(:return_cards).with(deck)
      player.return_cards(deck)
    end

    it "resets hand to nil" do
      player.return_cards(deck)
      expect(player.hand).to be_nil
    end
  end

####### FROM BLACK JACK's DEALER SPEC
  # describe "#play_hand" do
  #   let(:dealer_hand) { double("hand") }
  #   let(:deck) { double("deck") }

  #   before do
  #     dealer.hand = dealer_hand
  #   end

  #   it "does not hit on seventeen" do
  #     allow(dealer_hand).to receive_messages(
  #       :busted? => false,
  #       :points => 17
  #     )
  #     expect(dealer_hand).not_to receive(:hit)

  #     dealer.play_hand(deck)
  #   end

  #   it "hits until seventeen acheived" do
  #     allow(dealer_hand).to receive_messages(:busted? => false)

  #     # need to use a block to give points, because we'll hit hand and
  #     # points will change
  #     points = 12
  #     allow(dealer_hand).to receive(:points) do
  #       # returns `points` defined in the outside local variable. The
  #       # `points` variable is said to be *captured*.
  #       points
  #     end
  #     expect(dealer_hand).to receive(:hit).with(deck).exactly(3).times do
  #       # changes `points` variable above, faking addition of new
  #       # cards.
  #       points += 2
  #     end

  #     dealer.play_hand(deck)
  #   end

  #   it "stops when busted" do
  #     points = 16
  #     allow(dealer_hand).to receive(:points) { points }
  #     allow(dealer_hand).to receive(:busted?) { points > 21 }

  #     expect(dealer_hand).to receive(:hit).once.with(deck) do
  #       points = 22
  #     end

  #     dealer.play_hand(deck)
  #   end
  # end

  # context "with a player" do
  #   let(:player) { double("player", :hand => player_hand) }
  #   let(:dealer_hand) { double("dealer_hand") }
  #   let(:player_hand) { double("player_hand") }

  #   before(:each) do
  #     dealer.hand = dealer_hand
  #     allow(player).to receive_messages(:hand => player_hand)

  #     dealer.take_bet(player, 100)
  #   end

  #   it "records bets" do
  #     expect(dealer.bets).to eq({ player => 100 })
  #   end

  #   it "does not pay losers (or ties)" do
  #     expect(player_hand).to receive(:beats?).with(dealer_hand).and_return(false)
  #     expect(player).not_to receive(:pay_winnings)

  #     dealer.pay_bets
  #   end

  #   it "does pay winners" do
  #     expect(player_hand).to receive(:beats?).with(dealer_hand).and_return(true)

  #     # wins twice the bet
  #     expect(player).to receive(:pay_winnings).with(200)

  #     dealer.pay_bets
  #   end
  # end


end
