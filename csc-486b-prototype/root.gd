extends Node2D
@onready var cam = $Camera2D
@onready var player = $Foreground/Player
@onready var bg_sprite = $Background/Sprite2D

@export var bg_parallax: float

@export var levels: Array[PackedScene]
var level_index = 0
var cur_level: Level = null

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	cur_level = levels[level_index].instantiate()
	add_child(cur_level)
	pass


func _physics_process(delta: float) -> void:
	cam.position = player.position
	bg_sprite.position = cam.position / bg_parallax
	player.update(delta)
