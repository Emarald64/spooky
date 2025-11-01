class_name Ghost extends Area2D

const SPEED=150
const spriteXScale=0.1
static var ghostCount:=0
#var awake:=false
var animating:=true

func _ready()->void:
	ghostCount+=1
	if ghostCount==1:
		get_tree().call_group("disable when ghost",'disable')

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if not animating:
		if get_node('/root/main/player').global_position.distance_squared_to(global_position)<250000:
			$Sprite2D.scale.x=spriteXScale*signf(get_node('/root/main/player').global_position.x-global_position.x)
			position+=delta*SPEED*(get_node('/root/main/player').global_position-global_position).normalized()
		else:
			animating=true
			$AnimationPlayer.play("fadeOut")
			monitorable=false
			ghostCount-=1
			if ghostCount==0:
				get_tree().call_group("disable when ghost",'enable')
func reset()->void:
	queue_free()
	ghostCount-=1
	if ghostCount==0:
		get_tree().call_group("disable when ghost",'enable')

func _on_wake_up_timeout() -> void:
	animating=false
	monitorable=true
	$Sprite2D.modulate=Color.WHITE
