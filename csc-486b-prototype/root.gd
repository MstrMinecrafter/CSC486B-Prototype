extends Node2D
class_name Root
@onready var cam = $Camera2D
@export var bg_parallax: float
@export var levels: Array[PackedScene]
var level_index = 0
var cur_level: Level = null
var player: Player

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	add_level()

func _physics_process(delta: float) -> void:
	cur_level.update(delta)
	cam.position = player.position

func add_level():
	cur_level = levels[level_index].instantiate()
	cur_level.init(self)
	add_child(cur_level)
	player = cur_level.player

func inc_level():
	change_level(level_index + 1)

func change_level(level_index: int):
	self.level_index = level_index
	remove_child(cur_level)
	cur_level.queue_free()
	add_level()
