class_name HandScene extends Node2D

static var card_scene := preload("res://card_scene.tscn")

@export var is_player: bool = false
@export var is_horizontal: bool = true

var cards: Array = []

func deal(c: Card) -> void:
    var cs := card_scene.instantiate()
    add_child(cs)

    cs.card = c
    cs.face_up = is_player
    cs.ignore_mouse = is_player
    cards.append(cs)

    _update_card_positions()

func _update_card_positions() -> void:
    var card_width = cards[0].get_card_width()
    var card_x_gap = card_width - card_width / 2
    var max_width = (cards.size() - 1) * card_x_gap

    var card_height = cards[0].get_card_height()
    var card_y_gap = card_height - card_height * 4 / 5
    var max_height = (cards.size() - 1) * card_y_gap

    for i in range(cards.size()):
        var x_pos = card_x_gap * i - max_width / 2
        var y_pos = card_y_gap * i - max_height / 2
        cards[i].position = Vector2(x_pos, 0.0) if is_horizontal else Vector2(0.0, y_pos)
