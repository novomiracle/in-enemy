extends Node2D


# Declare member variables here. Examples:
# var a = 2
# var b = "text"
var damage = 15
var knockback = 500

# Called when the node enters the scene tree for the first time.
func _ready():
	$Explosion2.position +=Vector2(GameState.random.randf_range(-2,2),GameState.random.randf_range(-2,2))
	$Explosion3.position +=Vector2(GameState.random.randf_range(-2,2),GameState.random.randf_range(-2,2))


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass


func _on_boom_area_entered(area):
	if area.name == "hitbox":
		print(area.get_parent(),"rocket")
		area.get_parent().damage(damage,position,knockback)


func _on_AnimationPlayer_animation_finished(anim_name):
	queue_free()
