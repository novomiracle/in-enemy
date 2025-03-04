extends Node2D


# Declare member variables here. Examples:
# var a = 2
# var b = "text"


# Called when the node enters the scene tree for the first time.
# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass


func _on_soul_area_entered(area):
	if area.name == "hitbox" && area.get_parent().player:
		GameState.souls += 1
		queue_free()


func _on_Timer_timeout():
	$AnimationPlayer.play("die")
