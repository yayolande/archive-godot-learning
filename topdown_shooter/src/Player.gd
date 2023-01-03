extends KinematicBody2D

export(float) var move_speed : float = 500.0
export(float) var bullet_speed : float = 2000.0
export(PackedScene) var bullet : PackedScene = preload("res://src/scenes/Bullet.tscn")
# "onready" is only for object present on the scene. That's why it is a replacement
# for "$NodeName"
# onready var bullet = preload("")

func _ready():
	pass # Replace with function body.


func _physics_process(_delta):
	var motion = Vector2.ZERO

	if Input.is_action_pressed("move_up"):
		motion.y = -1
	if Input.is_action_pressed("move_down"):
		motion.y = 1
	if Input.is_action_pressed("move_left"):
		motion.x = -1
	if Input.is_action_pressed("move_right"):
		motion.x = 1
	
	if Input.is_action_pressed("fire"):
		fire()
	
	motion = motion.normalized()
	motion = move_and_slide(motion * move_speed)

	look_at(get_global_mouse_position())
	
	pass


func fire():
	var real_bullet = bullet.instance()
	# real_bullet.position = get_global_position()
	real_bullet.position = self.position
	real_bullet.rotation = self.rotation
	real_bullet.apply_impulse(Vector2.ZERO, (Vector2.RIGHT * bullet_speed).rotated(rotation))
	get_tree().get_root().call_deferred("add_child", real_bullet)
	
	pass



func _on_Area2D_body_entered(body:Node):
	if "Enemy" in body.name:
		kill()
	
	pass # Replace with function body.

func kill():
	var _success = get_tree().reload_current_scene()
	pass
