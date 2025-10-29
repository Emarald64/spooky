extends CanvasLayer

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta: float) -> void:
	$"gradient filter/static".texture.noise.seed+=1
	
func setInnerRadius(value:float)->void:
	$"gradient filter".texture.gradient.offsets[0]=value

func setOuterIntencity(value:float)->void:
	$"gradient filter".texture.gradient.colors[1].alpha=value
