extends Node2D
class_name Level

#@onready var entrance = $Entrance
#@onready var exit = $Exit

@onready var player = $Foreground/Player
@onready var bg_sprite = $Background/Sprite2D
@export var bg_parallax: float

func update(cam, delta):
	bg_sprite.position = cam.position / bg_parallax
	player.update(delta)
