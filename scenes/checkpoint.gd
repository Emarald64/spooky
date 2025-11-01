extends Area2D

var active:=false

func _on_area_entered(playerHitbox: Area2D) -> void:
	if not active:
		var player=playerHitbox.get_parent()
		player.checkpoint=self
		player.checkpointFlashlightBrightness=playerHitbox.get_node('../PointLight2D3')
		player.checkpointModulate=get_node('/root/CanvasModulate').color.r
		playerHitbox.get_node('../Camera2D').add_trauma(0.4)
		$PointLight2D.enabled=true
		active=true
		$AnimatedSprite2D.play('Up')
	
func deactivate()->void:
	active=false
	$AnimatedSprite2D.play('default')
	$PointLight2D.enabled=false
