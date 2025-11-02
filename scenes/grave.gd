extends Area2D

@export var ghostScene:PackedScene
var canSpawnGhost:=true
const ghostSpriteXScale:=0.1

func spawnGhost():
	# You've made a "grave" mistake ;)
	if canSpawnGhost:
		var ghost=ghostScene.instantiate()
		ghost.get_node("Sprite2D").scale.x*=signf(get_node('/root/main/player').global_position.x-global_position.x)
		ghost.position=global_position
		ghost.grave=self
		get_node('/root/main').add_child(ghost)
		canSpawnGhost=false

func reset():
	# allow spawning a ghost again
	canSpawnGhost=true
