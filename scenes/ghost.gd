class_name Ghost extends Area2D

const SPEED=150
const spriteXScale=0.1
const turningSpeed=1

static var ghostCount:=0
@export var despawnRadius:=500
var grave:Area2D
#var awake:=false
var animating:=true

func _ready()->void:
	ghostCount+=1
	if ghostCount==1:
		get_tree().call_group("disable when ghost",'disable')

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if not animating:
		if get_node('/root/main/player').global_position.distance_squared_to(global_position)<despawnRadius**2:
			if global_position.distance_squared_to(get_node('/root/main/player').global_position)>400:
				$Sprite2D.scale.x=clampf($Sprite2D.scale.x+(turningSpeed*delta*signf(get_node('/root/main/player').global_position.x-global_position.x)),-spriteXScale,spriteXScale)
				position+=delta*SPEED*(get_node('/root/main/player').global_position-global_position).normalized()
		else:
			reset()

func reset()->void:
	animating=true
	$AnimationPlayer.play("fadeOut")
	set_deferred('monitorable',false)
	ghostCount-=1
	grave.reset()
	if ghostCount==0:
		get_tree().call_group("disable when ghost",'enable')

func _on_wake_up_timeout() -> void:
	animating=false
	monitorable=true
	$Sprite2D.modulate=Color.WHITE
