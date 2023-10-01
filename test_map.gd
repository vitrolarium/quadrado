extends Node3D

var picked_coins : int = 0
var max_coins : int = 29
var current_time : float = 0
var ended = false
func _ready() -> void:
	%Player.position = %spawnpoint.position

func _on_player_picked() -> void:
	picked_coins += 1
	update_hud()
	if picked_coins >= max_coins:
		$hud/win.show()
		$win.play(57)
		ended = true

func _process(delta: float) -> void:
	if not ended:
		current_time += delta
		$hud/Label.set_text(str(snappedf(current_time, 0.01)))
		

func update_hud():
	$hud/Score.set_text("Coins: " + str(picked_coins) + ".")

func _on_death_area_body_entered(body: Node3D) -> void:
	get_tree().reload_current_scene()


func _on_win_finished() -> void:
	get_tree().reload_current_scene()
