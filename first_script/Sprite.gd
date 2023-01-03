extends Sprite

# Why are those champion not working ??
# export_group ("User Defined Fields")
export(int) var speed = 400
export(float) var angular_speed = PI

# var speed = 400
# var angular_speed = PI

var time : float = 0
var is_time_enabled : bool = true
signal max_time_alive(max_time, time_now)

# Constructor
func _init():
	print ("Hello World !")

func _ready():
	var timer = get_node ("Timer")
	timer.connect("timeout", self, "_on_Timer_timeout")
	# timer.timeout.connect(_on_Timer_timeout)
	self.connect("max_time_alive", self, "_on_Sprite_max_time_alive")

# "Ctrl + Click" on "_process" to see the documentation
# Function executed every frame. Only available for class inheriting from "Node"
func _process(delta):
	time += delta

	if is_time_enabled && time > 10 :
		emit_signal("max_time_alive", time)
		is_time_enabled = false
	
	
	rotation += angular_speed * delta
	var velocity = Vector2.UP.rotated(rotation) * speed
	position += velocity * delta
	# var direction = 0
	# if Input.is_action_pressed("ui_left"):
	# 	direction = -1
	# if Input.is_action_pressed("ui_right"):
	# 	direction = 1
		
	# rotation += angular_speed * direction * delta
	
	# var velocity = Vector2.ZERO
	# if Input.is_action_pressed("ui_up"):
	# 	velocity = Vector2.UP.rotated(rotation) * speed
	
	# position += velocity * delta
	#position = velocity + Vector2(500, 300)
	
# func _unhandled_input(event):
func _unhandled_input(_event):
	pass

# AWESOME DISCOVERY (due to this tutorial)
# This tutorial turn out to be a good example of player movement approach
# In a game, I know only of 2 ways to implement turning to the right and left
# The first one is simply to directly move the play to the right or left (OX) axis with a determined amount
# The second one is to turn following a mathematical path (circle, ellipse) so that a constant turn on that direction will draw that figure.
# This suppose that the player is constantly moving


func _on_Button_pressed():
	# pass # Replace with function body.
	set_process(not is_processing())

func _on_Timer_timeout():
	visible = not visible

func _on_Sprite_max_time_alive(alive_time) -> void:
	print ("Time of the event is : " + (alive_time as String))
	return


func _on_ToggleBlinking_pressed():
	var timer = get_node ("Timer")
	timer.one_shot = not timer.one_shot
	visible = true
	pass # Replace with function body.
