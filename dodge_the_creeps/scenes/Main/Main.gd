extends Node

export(PackedScene) var mob_scene
var score


# Called when the node enters the scene tree for the first time.
func _ready():
	randomize()
	# new_game()
	pass # Replace with function body.


func new_game():
	score = 0
	$Player.start($StartPosition.position)
	$StartTimer.start()
	get_tree().call_group("mobs", "queue_free")
	$HUD.update_score(score)
	$HUD.show_message("Get Ready")
	$Music.play()


func game_over():
	$ScoreTimer.stop()
	$MobTimer.stop()
	$HUD.show_game_over()
	$Music.stop()
	$DeathSound.play()
	pass # Replace with function body.


func _on_ScoreTimer_timeout():
	score += 1
	$HUD.update_score(score)
	pass # Replace with function body.


func _on_StartTimer_timeout():
	$MobTimer.start()
	$ScoreTimer.start()
	pass # Replace with function body.


func _on_MobTimer_timeout():
	var mob = mob_scene.instance()
	var mob_spawn_location = get_node ("MobPath/MobSpawnLocation")
	mob_spawn_location.offset = randi()
	prints ("PathFollow2D postion :", mob_spawn_location.position, 
		" --- rotation: ", mob_spawn_location.rotation, 
		" --- offset: ", mob_spawn_location.offset, 
		" --- object: ", mob_spawn_location.to_string()
		)
	
	var direction = mob_spawn_location.rotation + PI / 2
	direction += rand_range(- PI / 4, PI / 4)
	
	mob.position = mob_spawn_location.position
	mob.rotation = direction
	
	var velocity = Vector2(rand_range(150.0, 250.0), 0.0)
	mob.linear_velocity = velocity.rotated(direction)
	
	add_child(mob)
