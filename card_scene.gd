class_name CardScene extends Node2D

static var CARD_ASSETS := {}

@export var face_up: bool = true :
    set(v):
        face_up = v
        if v:
            _update_card_sprite()
        elif CARD_ASSETS:
            $CardSprite.texture = CARD_ASSETS["BLANK"]

@export var ignore_mouse: bool :
    get:
        return $CardSprite/Control.mouse_filter == Control.MouseFilter.MOUSE_FILTER_IGNORE
    set(v):
        $CardSprite/Control.mouse_filter = Control.MouseFilter.MOUSE_FILTER_STOP if v else Control.MouseFilter.MOUSE_FILTER_IGNORE

var card: Card :
    set(v):
        card = v
        _update_card_sprite()

func get_card_height():
    return $CardSprite.texture.get_height()

func get_card_width():
    return $CardSprite.texture.get_width()

func _ready():
    if CARD_ASSETS == {}:
        const asset_path_prefix = "res://assets/cards/card-"
        CARD_ASSETS["BLANK"] = load("%sback-blue.png" % [asset_path_prefix])

        var d := Deck.standard()
        while d.cards_remaining() > 0:
            var c := d.draw()

            var resource_name := "%s%s-%d.png" % [asset_path_prefix, c.suit_name.to_lower(), c.rank+1]
            CARD_ASSETS[c.inspect()] = load(resource_name)

func _update_card_sprite():
    if face_up:
        $CardSprite.texture = CARD_ASSETS[card.inspect()]

func _on_control_mouse_entered():
    $CardSprite/AnimationPlayer.play("Hover")

func _on_control_mouse_exited():
    $CardSprite/AnimationPlayer.play_backwards("Hover")
