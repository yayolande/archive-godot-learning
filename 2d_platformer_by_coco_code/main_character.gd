extends CharacterBody2D


const SPEED = 300.0
const JUMP_VELOCITY = -550.0

# Get the gravity from the project settings to be synced with RigidBody nodes.
var gravity = ProjectSettings.get_setting("physics/2d/default_gravity")
@onready var sprite_2d = $Sprite2D



func _physics_process(delta):
	if velocity.x < -1 || velocity.x > 1:
		sprite_2d.animation = "running"
	else :
		#sprite_2d.animation = "idle"
		sprite_2d.play("idle")
		
	# Add the gravity.
	if not is_on_floor():
		velocity.y += gravity * delta
		sprite_2d.play("jumping")
		


	# Handle jump.
	if Input.is_action_just_pressed("jump") and is_on_floor():
		velocity.y = JUMP_VELOCITY

	# Get the input direction and handle the movement/deceleration.
	# As good practice, you should replace UI actions with custom gameplay actions.
	var direction = Input.get_axis("left", "right")
	if direction:
		velocity.x = direction * SPEED
	else:
		velocity.x = move_toward(velocity.x, 0, 20)
		
	var player_horizontal_direction = velocity.x < 0
	sprite_2d.flip_h = player_horizontal_direction

	move_and_slide()
