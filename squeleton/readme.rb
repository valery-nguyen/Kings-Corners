# Run instructions in Terminal:
# ruby 'lib/board.rb'

# RULES:
# * The gameplay area starts with four foundation piles arranged on each
# side of the draw deck.
# * In addition, there are four corner piles that start empty.
# * These can only be built upon by placing a king in that pile first
# * Hence: "Kings Corners"
# * The goal is to be the first player to empty your hand.
# * Cards can be played/moved onto any other card in a solitaire-like pattern:
# * Descending by rank, alternating colors
# * e.g., Jack of Diamonds can be played on Queen of Spades
# * During a turn, a player can take four actions:
# * Play a correct card from their hand onto any non-empty pile
# * Play any card onto an empty foundation pile
# * Move a full pile onto another pile
#   * Must maintain the solitaire pattern
# * Play a King onto an empty corner pile
# * A player takes as many actions as they can on their turn
# * They end their turn by drawing a card from the top of the draw deck.
