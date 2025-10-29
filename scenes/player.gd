extends CharacterBody2D


const ACCEL = 1000
const JUMP_VELOCITY = -375
const dampening:=0.15
#const maxSpeed:=1000

var hasjumped:=false
var started_timer:=false
var deathCount:=0
var jumpTime:=0.0
const maxJumpTime=0.125
const spriteXScale:=0.33

var animating:=false


func  _process(_delta: float) -> void:
	$Flashlights.rotation=(Input.get_axis("look_up","look_down")*PI/4)

func _physics_process(delta: float) -> void:
	if Input.is_action_just_pressed("reset") and not animating:
		respawn()
	
	# Add the gravity.
	if not is_on_floor():
		#if $AnimatedSprite2D.frame==0 or jumpTime<maxJumpTime:$AnimatedSprite2D.frame=2
		velocity += get_gravity() * delta
		$AnimatedSprite2D.stop()
		$AnimatedSprite2D.frame=0
		if not started_timer:
			$coyoteTimer.start()
			started_timer=true
	else:
		#$AnimatedSprite2D.frame=0
		if velocity.x!=0:
			$AnimatedSprite2D.play()
			$AnimatedSprite2D.speed_scale=absf(velocity.x/200)
		else:
			$AnimatedSprite2D.stop()
			$AnimatedSprite2D.frame=0
		hasjumped=false
		started_timer=false
		$coyoteTimer.stop()
		
	#if not animating and$Collect.has_overlapping_areas() and $Collect.get_overlapping_areas()[0].has_meta("animation"):
		#$"Interact Prompt".show()
		#if Input.is_action_just_pressed("jump"):
			#get_node("../AnimationPlayer").play($Collect.get_overlapping_areas()[0].get_meta("animation"))
	#else:$"Interact Prompt".hide()
			
	# Handle jump.
	if not animating and ((Input.is_action_pressed("jump") and jumpTime<0.1) or (Input.is_action_just_pressed("jump") and (not $coyoteTimer.is_stopped() or is_on_floor()))):
		if not hasjumped:
			$"Jump Sound".play()
			#$AnimatedSprite2D.frame=1
		$coyoteTimer.stop()
		if not hasjumped:
			jumpTime=0.0
		var jump=JUMP_VELOCITY*((1.0 if not hasjumped and Input.is_action_just_pressed("jump") else 0.0) + (delta*10) if jumpTime+delta<maxJumpTime else (maxJumpTime-jumpTime)*10)
		velocity.y=max(velocity.y+jump,-700)
		jumpTime+=delta

		hasjumped=true
		

	# Get the input direction and handle the movement/deceleration.
	# As good practice, you should replace UI actions with custom gameplay actions.
	if not animating:
		#if not is_on_floor():velocity.y+=Input.get_axis("move_up", "move_down")*200*delta
		var direction := Input.get_axis("move_left", "move_right")
		if direction:
			$AnimatedSprite2D.scale.x=spriteXScale*signf(direction)
			$Flashlights.scale.x=signf(direction)
			velocity.x+=direction*ACCEL*delta*(1 if signf(velocity.x)==signf(direction) else 2)
		else:
			velocity.x-=minf(ACCEL*2*delta,abs(velocity.x))*signf(velocity.x)
		velocity.x*=pow(dampening,delta)
	else:velocity.x=0

	#$Label.text=str(velocity)
	move_and_slide()

func respawn()->void:
	pass

func setFlashlightScale(val:float):
	get_tree().set_group("flashlight","offset",Vector2.ONE*val*16)
	get_tree().set_group("flashlight","texture_scale",val)
