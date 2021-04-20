extends CanvasLayer
signal start_game

# Declare member variables here. Examples:
# var a = 2
# var b = "text"

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.

func _on_MessageTimer_timeout():
	$Message.hide()

func _on_ReadyBtn_pressed():
	$ReadyBtn.hide()
	emit_signal("start_game")
	$Message.hide()

func show_message(text):
	$Message.text = text
	$Message.show()
	$MessageTimer.start()

func show_game_over():
	show_message("Game Over")
	# Wait until the MessageTimer has counted down.
	yield($MessageTimer, "timeout")
	$Message.text = "Dodge the\nCreeps!"
	$Message.show()
	# Make a one-shot timer and wait for it to finish.
	yield(get_tree().create_timer(1), "timeout")
	$ReadyBtn.show()
	
func update_lifes(lifes):
	$LifeCount.text = str(lifes)

func update_score(score):
	$ScoreLabel.text = str(score)
