extends Node2D

func open()->void:
	$AnimationPlayer.play("open")
	
func close()->void:
	$AnimationPlayer.play_backwards("open")
