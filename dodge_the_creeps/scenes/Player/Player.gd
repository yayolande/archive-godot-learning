extends Area2D

export var speed : int = 400
export var speed_up : int = (400 * 0.33) as int
var screen_size : Vector2
signal hit

# Called when the node enters the scene tree for the first time.
func _ready():
	screen_size = get_viewport_rect().size
	hide()
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	var horizontal_direction : int = 0
	var vertical_direction : int = 0
	var bonus_speed : int = 0

	if Input.is_action_just_pressed("power_play"):
		power_play()
	if Input.is_action_pressed("move_up"):
		vertical_direction = -1
	elif Input.is_action_pressed("move_down"):
		vertical_direction = 1

	if Input.is_action_pressed("move_right"):
		horizontal_direction = 1
	elif Input.is_action_pressed("move_left"):
		horizontal_direction = -1
	
	if Input.is_action_pressed("move_speedup"):
		bonus_speed = speed_up
	
	var velocity : Vector2 = Vector2 (horizontal_direction, vertical_direction)

	if velocity.length() > 0:
		velocity = velocity.normalized() * (speed + bonus_speed)
		$AnimatedSprite.play()
	else:
		$AnimatedSprite.stop()
	
	if velocity.x != 0:
		$AnimatedSprite.animation = "walk"
		$AnimatedSprite.flip_v = false
		$AnimatedSprite.flip_h = velocity.x < 0
	elif velocity.y != 0:
		$AnimatedSprite.animation = "up"
		$AnimatedSprite.flip_v = velocity.y > 0
		$AnimatedSprite.flip_h = false
	
	position += velocity * delta
	position.x = clamp(position.x, 0, screen_size.x)
	position.y = clamp(position.y, 0, screen_size.y)
	
	pass

func power_play():
	visible = not visible
	pass

func start(pos):
	position = pos
	$CollisionShape2D.disabled = false
	show()
	pass


func _on_Player_body_entered(body):
	hide()
	emit_signal("hit")
	# Must be deferred as we can't change physics properties on a physics callback.
	$CollisionShape2D.set_deferred("disabled", true)
	pass # Replace with function body.
