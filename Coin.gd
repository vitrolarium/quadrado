extends Area3D

func _ready() -> void:
	$coin/AnimationPlayer.speed_scale = randf_range(0.8, 1.2)
	$coin/AnimationPlayer.play("float")


func _on_body_entered(body: Node3D) -> void:
	if body.is_in_group("player"):
		body.emit_signal("picked")
		queue_free()
