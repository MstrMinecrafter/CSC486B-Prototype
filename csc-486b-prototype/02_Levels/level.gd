extends Node2D
class_name Level

var player: Player
var bg_sprite: Sprite2D
var entrance: Marker2D
var exit: Area2D
var root: Root

func init(root) -> void:
	player = $Foreground/Player
	bg_sprite = $Background/Sprite2D
	entrance = $Entrance
	exit = $Exit
	self.root = root
	player.position = entrance.position

func update(delta):
	bg_sprite.position = root.cam.position / root.bg_parallax
	player.update(delta)
	check_for_exit()

func check_for_exit():
	var overlapping_areas = exit.get_overlapping_areas()
	for overlapping_area in overlapping_areas:
		if overlapping_area.get_parent() is Player:
			root.inc_level()
			break
