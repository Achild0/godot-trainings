extends Node

export (PackedScene) var Mob
var score
# Declare member variables here. Examples:
# var a = 2
# var b = "text"

# Called when the node enters the scene tree for the first time.
func _ready():
	randomize()
	$Player.hide()

func game_over():
	$MobTime.stop()
	$ScoreTimer.stop()
	get_tree().call_group("Mob","queue_free")
	$HUD.show_game_over()
	
	
func start_game():
	$Player.spawn($Position2D.position)
	$HUD.update_lifes($Player.get_lifes())
	$StartTimer.start()
	score = 0
	$Player.show()
	
func new_game():
	$HUD.update_score(score)
	$HUD.show_message("Get Ready")
	start_game()

func _on_ScoreTimer_timeout():
	score += 1
	$HUD.update_score(score)

func _on_StartTimer_timeout():
	$MobTime.start()
	$ScoreTimer.start()

func _on_MobTime_timeout():
	# Choose a random location on Path2D.
	$MobPath/MobSpawnLocation.offset = randi()
	# Create a Mob instance and add it to the scene.
	var mob = Mob.instance()
	add_child(mob)
	# Set the mob's direction perpendicular to the path direction.
	var direction = $MobPath/MobSpawnLocation.rotation + PI / 2
	# Set the mob's position to a random location.
	mob.position = $MobPath/MobSpawnLocation.position
	# Add some randomness to the direction.
	direction += rand_range(-PI / 4, PI / 4)
	mob.rotation = direction
	# Set the velocity (speed & direction).
	mob.linear_velocity = Vector2(rand_range(mob.min_speed, mob.max_speed), 0)
	mob.linear_velocity = mob.linear_velocity.rotated(direction)


func _on_Player_dead():
	game_over()


func _on_Player_hit():
	$HUD.update_lifes($Player.get_lifes())
