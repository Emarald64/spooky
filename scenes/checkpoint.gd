extends Area2D

var active:=false

func _on_area_entered(playerHitbox: Area2D) -> void:
	if not active:
		playerHitbox.get_parent().checkpoint=self
		$PointLight2D.enabled=true
		active=true
		$AnimatedSprite2D.play('Up')
	
func deactivate()->void:
	active=false
	$AnimatedSprite2D.play('default')
	$PointLight2D.enabled=false
