extends CharacterBody2D
class_name Player

@export var SPEED: float
@export var JUMP_VELOCITY: float

@onready var wall_blend_area = $WallBlendArea

var colour = "black"

func update(delta: float):
	move(delta)
	detect_overlaps()

func detect_overlaps():
	var overlapping_areas = wall_blend_area.get_overlapping_areas()
	for overlapping_area in overlapping_areas:
		if overlapping_area.get_parent() is Wall and overlapping_area.get_parent().colour == colour:
			print("hello")
		if overlapping_area.name == "Body" and overlapping_area.get_parent() is Enemy:
			var root = get_tree().root.get_node("Root") as Root #kind of a hacky way of handling death but whatever
			root.change_level(root.level_index)

func move(delta: float) -> void:
	# Add the gravity.
	if not is_on_floor():
		velocity += get_gravity() * delta

	# Handle jump.
	if (Input.is_action_just_pressed("ui_accept") or Input.is_action_just_pressed("ui_up")) and is_on_floor():
		velocity.y = -JUMP_VELOCITY

	var direction := Input.get_axis("ui_left", "ui_right")
	if direction:
		velocity.x = direction * SPEED
	else:
		velocity.x = move_toward(velocity.x, 0, SPEED)

	move_and_slide()
