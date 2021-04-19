extends Area2D
signal hit
signal dead


# Exports
export var INIT_LIFES = 3 # How much lifes you want at the beginning of the game
export var speed = 400  # How fast the player will move (pixels/sec).

# Vars
var lifes = INIT_LIFES # How much lifes you've got
var screen_size  # Size of the game window.

# Called when the node enters the scene tree for the first time.
func _ready():
	screen_size = get_viewport_rect().size

func _process(delta):
	var velocity = Vector2()
	
	if Input.is_action_pressed("char_right"):
		velocity.x += 1
	if Input.is_action_pressed("char_left"):
		velocity.x -= 1
	if Input.is_action_pressed("char_up"):
		velocity.y -= 1
	if Input.is_action_pressed("char_down"):
		velocity.y += 1
	if velocity.length() > 0:
		velocity = velocity.normalized() * speed
		$AnimatedSprite.play()
		$PlayerTrail.emitting = true
	else:
		$PlayerTrail.emitting = false
		$AnimatedSprite.stop()
		
	position += velocity * delta
	position.x = clamp(position.x, 0, screen_size.x)
	position.y = clamp(position.y, 0, screen_size.y)
	
	if velocity.x != 0:
		$AnimatedSprite.animation = "walk"
		$AnimatedSprite.flip_v = false
		$AnimatedSprite.flip_h = velocity.x < 0
	elif velocity.y != 0:
		$AnimatedSprite.animation = "up"
		$AnimatedSprite.flip_v = velocity.y > 0

# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass


func _on_Player_body_entered(body):
	lifes -= 1
	$CollisionShape2D.set_deferred("disabled",true)
	if lifes == 0:
		emit_signal("dead")
		
	else:
		emit_signal("hit")


func _on_Hit_invicibility_timeout():
	$CollisionShape2D.set_deferred("disabled",false)

func get_lifes():
	return lifes

func spawn(pos):
	position = pos
	show()
	$CollisionShape2D.disabled = false
	lifes = INIT_LIFES
