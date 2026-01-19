class_name Deck

var cards: Array

static func standard() -> Deck:
    var deck := Deck.new()
    for s in Card.Suit.values():
        for r in Card.Rank.values():
            var c := Card.new()
            c.set_card(r, s)
            deck.cards.append(c)
    return deck

func shuffle():
    cards.shuffle()

func draw() -> Card:
    return cards.pop_front()

func cards_remaining() -> int:
    return cards.size()
