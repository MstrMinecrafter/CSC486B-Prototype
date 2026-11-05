extends Node2D
@onready var cam = $Camera2D

@export var levels: Array[PackedScene]
var level_index = 0
var cur_level: Level = null
var player: Player

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	cur_level = levels[level_index].instantiate()
	add_child(cur_level)
	player = cur_level.player

func _physics_process(delta: float) -> void:
	cur_level.update(cam,delta)
	cam.position = player.position
