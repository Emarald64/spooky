extends Node2D

var startTime:=0
var startedTimer:=false

func updateLightIntencity(val:float)->void:
	$player.setFlashlightScale(max(0.5-val,0)*12)
	#$player/PointLight2D3.texture_scale=6*max(0.5-val,0)
	$CanvasModulate.color=Color(val,val,val,1)

func setModulateBrighness(val:float)->void:
	$CanvasModulate.color=Color(val,val,val,1)

func _ready() -> void:
	updateLightIntencity(0.9)
	$CanvasModulate.visible=true

func startTimer()->void:
	if not startedTimer:
		startTime=Time.get_ticks_msec()
		startedTimer=true

func _process(delta: float) -> void:
	print((Time.get_ticks_msec()-startTime)/1000.0)

func stopTimer()->void:
	$"End Area/Time".text="Time: "+formatTime((Time.get_ticks_msec()-startTime)/1000.0)

static func formatTime(time:float) -> String:
	return str(floori(time/60)).pad_zeros(1)+":"+str(floori(time)%60).pad_zeros(2)+"."+str(floori(time*100)%100).pad_zeros(2)
