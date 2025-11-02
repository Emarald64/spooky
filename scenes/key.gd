extends Area2D

func disable()->void:
	monitoring=false
	$Sprite2D.modulate=Color(0.2,0.2,0.2)
	
func enable()->void:
	monitoring=true
	$Sprite2D.modulate=Color.WHITE


func collected(area: Area2D) -> void:
	area.get_node('../Camera2D').add_trauma(0.3)
	queue_free()
