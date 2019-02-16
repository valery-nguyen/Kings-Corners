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
        
        populate_piles(deck)
        
    end

    def populate_piles(deck)
        #foundation piles
        kings_draw_starting = []
        4.times do 
            new_card = deck.take(1)
            until new_card.first.rank != 13
                kings_draw_starting += new_card
                new_card = deck.take(1)
            end
            @piles << Pile.new(new_card)
        end
        #corner piles
        4.times{@piles << Pile.new}
        #place kings drawn at start in corner piles
        kings_draw_starting.each do |k|
            (4..7).each do |i|
                if piles[i].empty?
                    @piles[i].play(k) 
                    break
                end
            end
        end
    end

    def render
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
    end

    def start_game
        winner = ""
        system("clear")
        render
        sleep(2)
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
        system("clear")
        render
        puts "#{winner} won! Game Over."
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

game

#load 'lib/board.rb'

