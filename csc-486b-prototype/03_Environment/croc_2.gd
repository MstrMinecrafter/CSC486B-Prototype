extends Sprite2D


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	$croc2.play("wait")
	await $croc2.animation_finished
	$croc2.play("idle")


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
