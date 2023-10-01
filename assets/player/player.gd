extends CharacterBody3D

@export var speed : int = 15
@export var jump_force : int = 15
@export var blend_anim : float = 1

var direction : float
signal picked

func _physics_process(delta: float) -> void:
	direction = Input.get_axis("move_left", "move_right")
	if direction:
		velocity.z = -direction * speed
		$player/AnimationPlayer.play("run", blend_anim)
		$player.rotation_degrees.y = 180 if direction > 0 else 0
		if not $sfx/run.playing:
			$sfx/run.play()
	else:
		velocity.z = 0
		$player/AnimationPlayer.play("idle", blend_anim)
		if $sfx/run.playing:
			$sfx/run.stop()
	
	if not is_on_floor():
		velocity.y -= 1
		$player/AnimationPlayer.play("jump", blend_anim)
	elif Input.is_action_just_pressed("jump"):
		velocity.y = jump_force
	
	move_and_slide()
		

func _process(delta: float) -> void:
	%Camera.h_offset = lerp(%Camera.h_offset, direction * 1, .125)
	%Camera.position.z = position.z
	%Camera.position.y = lerp(%Camera.position.y, position.y, .125)


func _on_picked() -> void:
	$sfx/coin.play()
