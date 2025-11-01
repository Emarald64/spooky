extends Area2D

var active:=false
var enabled:=true

func _on_area_entered(playerHitbox: Area2D) -> void:
	if not active and enabled:
		var player=playerHitbox.get_parent()
		player.checkpoint=self
		player.checkpointFlashlightBrightness=playerHitbox.get_node('../Flashlights/Flashlight').texture_scale
		player.checkpointModulate=get_node('/root/main/CanvasModulate').color.r
		playerHitbox.get_node('../Camera2D').add_trauma(0.4)
		$PointLight2D.enabled=true
		active=true
		$AnimatedSprite2D.play('Up')
	
func deactivate()->void:
	active=false
	$AnimatedSprite2D.play('default')
	$PointLight2D.enabled=false
	
func disable()->void:
	enabled=false
	$AnimatedSprite2D.modulate=Color(0.2,0.2,0.2)
	
func enable()->void:
	enabled=true
	$AnimatedSprite2D.modulate=Color.WHITE
