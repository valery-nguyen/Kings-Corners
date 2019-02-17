require 'board'

describe Board do
    let(:card) { double("card") }
    let(:deck) { double("deck") }
    let(:player1) { double("player") }
    let(:player2) { double("player") }
    let(:players) { [player1, player2] }
    let(:pile) { double("pile") }
    subject(:board) { Board.new(deck, players) }

    describe '#initialize' do
        it 'initializes correctly' do
            allow(Pile).to receive(:new).and_return(pile)
            allow(deck).to receive(:take).with(1).and_return(card)
            expect(board.deck).to eq(deck)
            expect(board.players).to eq(players)
        end
    end
end