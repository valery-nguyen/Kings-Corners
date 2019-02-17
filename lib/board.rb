require_relative 'card'
require_relative 'deck'
require_relative 'hand'
require_relative 'pile'
require_relative 'player'

require "byebug"

class Board
    attr_accessor :deck, :piles, :players

    def initialize(deck, players)
        @deck = deck
        @piles = []
        @players = players

        #foundation piles
        4.times{ @piles << Pile.new(deck.take(1)) }
        #corner piles
        4.times{@piles << Pile.new}
    end

    def render
        system("clear")
        (0..3).each do |i|
            puts "Foundation pile #{i+1}:"
            sub = ""
            piles[i].seq.each { |e| sub << e.to_s << " " }
            puts sub
        end

        (4..7).each do |i|
            puts "Corner pile #{i-3}:"
            sub = ""
            piles[i].seq.each { |e| sub << e.to_s << " " }
            puts sub
        end
        puts "====="
        players.each do |player|
            puts "#{player.name}'s hand:"
            sub = ""
            player.hand.cards.each { |e| sub << e.to_s << " " }
            puts sub
        end
        sleep(2)
    end

    def start_game
        winner = ""
        render
        while true
            players.each do |player|
                player.play_hand(self)
                if player.won?
                    winner = player.name
                    break
                end
            end
            break if winner != ""
        end
        render
        puts "#{winner} won! Game Over."
        puts "====="
        puts "Final points count:"
        players.each do |player|
            player.update_points
            puts "#{player.name} has #{player.points} points"
        end
        sleep(5)
        Process.exit
    end

end

def game
    deck = Deck.new
    player1 = Player.new("Val", deck)
    player2 = Player.new("Esha", deck)
    player3 = Player.new("Tommy", deck)
    player4 = Player.new("Mashu", deck)
    players = [player1, player2, player3, player4]
    board = Board.new(deck, players)
    board.start_game
end

# game

#load 'lib/board.rb'
