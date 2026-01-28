class_name CardScene extends Node2D

class CardAssets:
    static var ASSETS := {}

    const asset_path_prefix = "res://assets/cards/card-"

    func get_or_load_blank_card():
        if !ASSETS.has("BLANK"):
            ASSETS["BLANK"] = load("%sback-blue.png" % [asset_path_prefix])

        return ASSETS["BLANK"]

    func get_or_load(card: Card):
        if !ASSETS.has(card.inspect()):
            var resource_name := "%s%s-%d.png" % [asset_path_prefix, card.suit_name.to_lower(), card.rank + 1]
            ASSETS[card.inspect()] = load(resource_name)

        return ASSETS[card.inspect()]

    func load_all():
        get_or_load_blank_card()

        var d := Deck.standard()
        while d.cards_remaining() > 0:
            var c := d.draw()
            get_or_load(c)

# NB: All assets could potentially be getting lazy loaded, but shouldn't be a problem here
static var CARD_ASSETS := CardAssets.new()

@export var face_up: bool = true :
    set(v):
        face_up = v
        if v:
            _update_card_sprite()
        else:
            $CardSprite.texture = CARD_ASSETS.get_or_load_blank_card()

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
    CARD_ASSETS.load_all()

func _update_card_sprite():
    if face_up:
        $CardSprite.texture = CARD_ASSETS.get_or_load(card)

func _on_control_mouse_entered():
    $CardSprite/AnimationPlayer.play("Hover")

func _on_control_mouse_exited():
    $CardSprite/AnimationPlayer.play_backwards("Hover")
