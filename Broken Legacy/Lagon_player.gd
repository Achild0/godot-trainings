extends KinematicBody2D


var run_speed = 350
var jump_speed = -1000
var gravity = 2500

var velocity = Vector2()

func _ready():
	pass

func get_input():
	velocity.x = 0
	var right = Input.is_action_pressed('ui_right')
	var left = Input.is_action_pressed('ui_left')
	var down = Input.is_action_pressed('ui_down')
	var up = Input.is_action_pressed('ui_up')
	var jump = Input.is_action_just_pressed('ui_select')

	if is_on_floor() and jump:
		velocity.y = jump_speed
	if down:
		velocity.y += run_speed
	if right:
		velocity.x += run_speed
	if left:
		velocity.x -= run_speed
	
	if velocity.x > 0:
		$AnimatedSprite.animation = "walk"
		$AnimatedSprite.play()
		$AnimatedSprite.flip_h = false
	elif velocity.x < 0:
		$AnimatedSprite.animation = "walk"
		$AnimatedSprite.play()
		$AnimatedSprite.flip_h = true
	else:
		$AnimatedSprite.animation = "idle"
		$AnimatedSprite.play()

func _physics_process(delta):
	velocity.y += gravity * delta
	get_input()
	velocity = move_and_slide(velocity, Vector2(0, -1))
