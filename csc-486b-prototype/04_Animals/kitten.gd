extends Path2D

@export var speed: float
@onready var pathfollow2d: PathFollow2D = $PathFollow2d
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	var new_prog_ratio = pathfollow2d.progress_ratio + speed * delta / curve.get_baked_length()
	if new_prog_ratio >= 1:
		get_parent().remove_child(self)
		queue_free()
	else:
		pathfollow2d.progress_ratio = new_prog_ratio
