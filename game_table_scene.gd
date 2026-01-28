class_name GameTableScene extends Node2D

var deck: Deck = Deck.standard()

@onready var hands := [$PlayerHand, $OpponentLeft, $OpponentTop, $OpponentRight]

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
    deck.shuffle()
    _deal_out_hands()

func _deal_out_hands() -> void:
    for i in range(deck.cards_remaining()):
        var drawn_card = deck.draw()
        hands[i % hands.size()].deal(drawn_card)
