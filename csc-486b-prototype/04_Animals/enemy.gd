extends Node2D
class_name Enemy

@export var speed: float
@export var flying: bool
@onready var patrol: Path2D = $Patrol
@onready var patrol_follow: PathFollow2D = $Patrol/PatrolFollow
@onready var detection_area: Area2D = $DetectionArea
@onready var body: Area2D = $Body
var target: Player = null
var on_path: bool = true
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.

func detect_player():
	var overlapping_areas = detection_area.get_overlapping_areas()
	for overlapping_area in overlapping_areas:
		var overlap_parent = overlapping_area.get_parent()
		if overlap_parent is Player and not overlap_parent.blending_in:
			target = overlap_parent
			on_path = false
			return
	target = null

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	detect_player()
	if target == null and on_path:
		patrol_follow.progress_ratio = patrol_follow.progress_ratio + speed * delta / patrol.curve.get_baked_length()
		body.position = patrol_follow.position
	elif target != null:
		var step = (target.global_position - body.global_position).normalized() * speed * delta
		if flying:
			body.position += step
		else:
			body.position.x += step.x
	else:
		var diff = patrol_follow.global_position - body.global_position
		body.position += diff.normalized() * speed * delta
		if diff.length() < 0.1:
			on_path = true
		
