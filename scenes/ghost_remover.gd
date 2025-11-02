extends Area2D

func remove_ghosts(_area: Area2D) -> void:
	get_tree().call_group("Removed by cleaner",'reset')
