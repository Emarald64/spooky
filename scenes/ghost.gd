extends Area2D

const SPEED=200
const spriteXScale=0.33

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if get_node('/root/main/player').global_position.distance_squared_to(global_position)<1000000:
		$Sprite2D.scale.x=spriteXScale*signf(get_node('/root/main/player').global_position.x-global_position.x)
		position+=delta*SPEED*(get_node('/root/main/player').global_position-global_position).normalized()
	else:
		print('too far')
		queue_free()
func reset()->void:
	queue_free()
