extends CanvasLayer

signal start_game

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


func show_message (text):
	$Message.text = text
	$Message.show()
	$MessageTimer.start()
	pass


func show_game_over():
	show_message("Game Over")
	yield ($MessageTimer, "timeout")

	$Message.text = "Dodge the\nCreeps!"
	$Message.show()

	yield (get_tree().create_timer(1), "timeout")
	$StartButton.show()
	pass


func update_score (score):
	$ScoreLabel.text = str(score)

func _on_MessageTimer_timeout():
	$Message.hide()
	pass # Replace with function body.


func _on_StartButton_pressed():
	$StartButton.hide()
	emit_signal("start_game")
	pass # Replace with function body.
