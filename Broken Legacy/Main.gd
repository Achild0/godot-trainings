extends Node


# Declare member variables here. Examples:
# var a = 2
# var b = "text"


# Called when the node enters the scene tree for the first time.
func _ready():
	$Lagon_player.position = $Position2D.position
	$Camera2D.make_current()



func _process(delta):
	$Camera2D.position = $Lagon_player.position

