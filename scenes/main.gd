extends Node2D

func updateLightIntencity(val:float)->void:
	$player.setFlashlightScale(max(0.5-val,0)*12)
	#$player/PointLight2D3.texture_scale=6*max(0.5-val,0)
	$CanvasModulate.color=Color(val,val,val,1)

func setModulateBrighness(val:float)->void:
	$CanvasModulate.color=Color(val,val,val,1)

func _ready() -> void:
	updateLightIntencity(0.9)
	$CanvasModulate.visible=true

#func _process(_delta: float) -> void:
	#updateLightIntencity(fmod(Time.get_ticks_msec()/10000.0,1.0))
