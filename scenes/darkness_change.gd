extends Area2D

@export var vertical:=false
@export var minPositionDarkness:=0.0
@export var maxPositionDarkness:=1.0
const buffer:=16
@onready var main:Node2D=get_node('/root/main')

signal newIntencity(intencity:float)

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta: float) -> void:
	if(has_overlapping_areas()):
		newIntencity.emit(lerpf(minPositionDarkness,maxPositionDarkness,getProgress(get_overlapping_areas()[0].global_position-global_position)))
		#print(getProgress(get_overlapping_areas()[0].global_position-global_position))
		#main.updateLightIntencity(newIntencity)

func getProgress(relativePos:Vector2)->float:
	return clampf( 
		(getThePartOfTheVectorThatActuallyMatters(relativePos)-buffer )
		/(getThePartOfTheVectorThatActuallyMatters($CollisionShape2D.shape.size*scale)-(2*buffer))
	,0.0,1.0)

func getThePartOfTheVectorThatActuallyMatters(vector:Vector2)->float:
	return vector.y if vertical else vector.x
