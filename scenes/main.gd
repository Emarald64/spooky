extends Node2D

func updateLightIntencity(val:float)->void:
	$player.setFlashlightScale(max(0.5-val,0)*12,true)
	#$player/PointLight2D3.texture_scale=6*max(0.5-val,0)
	$CanvasModulate.color=Color(val,val,val,1)

func _ready() -> void:
	updateLightIntencity(1.0)
	$CanvasModulate.visible=true

#func _process(_delta: float) -> void:
	#updateLightIntencity(fmod(Time.get_ticks_msec()/10000.0,1.0))

#
#func triggerInfinateLoop() -> void:
	#if $player.velocity.x<0:
		## loop
		#print('loop')
		#$player.position.x+= 128


#func setUpInfinateLoop() -> void:
	#print('set up loop')
	#$player/Camera2D.drag_left_margin=0.3111111111
