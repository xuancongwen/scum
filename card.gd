class_name Card

enum Rank {
    ACE,
    TWO,
    THREE,
    FOUR,
    FIVE,
    SIX,
    SEVEN,
    EIGHT,
    NINE,
    TEN,
    JACK,
    QUEEN,
    KING
}

enum Suit {
    HEARTS,
    DIAMONDS,
    CLUBS,
    SPADES
}

var rank: Rank :
    get:
        return rank
    set(value):
        rank = value
        rank_name = Rank.keys()[rank]

var suit: Suit :
    get:
        return suit
    set(value):
        suit = value
        suit_name = Suit.keys()[suit]

var rank_name: String
var suit_name: String

func set_card(r: Rank, s: Suit):
    rank = r
    suit = s

func inspect() -> String:
    return "%s of %s" % [rank_name, suit_name]
