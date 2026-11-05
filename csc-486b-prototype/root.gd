extends Node2D
@onready var cam = $Camera2D
@onready var player = $Foreground/Player
@onready var bg_sprite = $Background/Sprite2D

@export var bg_parallax: float

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


func _physics_process(delta: float) -> void:
	cam.position = player.position
	bg_sprite.position = cam.position / bg_parallax
	player.update(delta)
