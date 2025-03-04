extends "res://scripts/projectile.gd"


# Declare member variables here. Examples:
# var a = 2
# var b = "text"

func shoot():
	rotation_degrees =rad2deg( Vector2.RIGHT.angle_to(direction))
	speed = 200
	damage = 10
	knockback = 150
# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
