extends Node2D
class_name Wall

@export var colour: Color

func _ready():
	$Area2D/CollisionShape2D/ColorRect.color = colour
