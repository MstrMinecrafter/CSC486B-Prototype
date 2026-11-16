extends CharacterBody2D
class_name Player

@export var SPEED: float
@export var JUMP_VELOCITY: float
@export var CLIMB_SPEED: float = 100.0

@onready var wall_blend_area = $WallBlendArea
@onready var sprite = $Sprite2D

var colour = Color.BLACK
var blending_in = false
var on_ladder = false
var climbing = false
@export var check = "black"

func _ready() -> void:
	add_to_group("player")
	apply_colour()

func apply_colour() -> void:
	sprite.material.set_shader_parameter("add_colour", colour)

func update(delta: float):
	detect_overlaps()
	move(delta)

func detect_overlaps():
	blending_in = false
	on_ladder = false
	var overlapping_areas = wall_blend_area.get_overlapping_areas()
	for overlapping_area in overlapping_areas:
		var overlap_parent = overlapping_area.get_parent()
		if overlap_parent is Ladder and not is_on_floor():
			on_ladder = true
		if overlap_parent is Wall and overlap_parent.colcheck == check:
			blending_in = true
		if (overlapping_area.name == "Body" and overlap_parent is Enemy and not blending_in) or overlap_parent is Killbox:
			var root = get_tree().root.get_node("Root") as Root
			root.change_level(root.level_index)
		if overlap_parent is ColourChanger:
			colour = overlap_parent.colour
			check = overlap_parent.colcheck
			apply_colour()
			
	#print(colour)
	#print(blending_in)

	# Lost the ladder, so stop climbing
	if not on_ladder:
		climbing = false

func move(delta: float) -> void:
	var vertical = Input.get_axis("ui_up", "ui_down")

	# Start climbing when pressing up/down while on a ladder
	if on_ladder:
		climbing = true

	if climbing:
		climb(vertical)
	else:
		walk(delta)

	move_and_slide()

func climb(vertical: float) -> void:
	velocity.y = vertical * CLIMB_SPEED

	var direction = Input.get_axis("ui_left", "ui_right")
	if direction > 0:
			$Sprite2D.flip_h = false
	elif direction < 0:
			$Sprite2D.flip_h = true
	velocity.x = direction * SPEED * 0.5  # slower sideways movement on ladder

	# Jump off the ladder
	if Input.is_action_just_pressed("ui_accept"):
		climbing = false
		velocity.y = -JUMP_VELOCITY

func walk(delta: float) -> void:
	if not is_on_floor():
		velocity += get_gravity() * delta

	if (Input.is_action_just_pressed("ui_accept") or Input.is_action_just_pressed("ui_up")) and is_on_floor():
		velocity.y = -JUMP_VELOCITY

	var direction = Input.get_axis("ui_left", "ui_right")
	if direction > 0:
			$Sprite2D.flip_h = false
	elif direction < 0:
			$Sprite2D.flip_h = true
	if direction:
		velocity.x = direction * SPEED
	else:
		velocity.x = move_toward(velocity.x, 0, SPEED)
