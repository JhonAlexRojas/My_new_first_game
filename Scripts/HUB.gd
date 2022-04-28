extends CanvasLayer


var score = 0
var game_over = false
onready var speed = get_node("../Cave").speed


func _ready():
	get_node("../CRT/ColorRect").visible = Global.crt_mode


func _process(_delta):
	if game_over:
		# Restart and exit
		if Input.is_action_just_pressed("ui_retry"):
			get_tree().call_deferred("reload_current_scene")
		elif Input.is_action_just_pressed("ui_exit"):
			get_tree().call_deferred("change_scene", "res://Scenes/Menu.tscn")
	else:
		get_node("ScoreContainer/Score").text = str(score)
		score += speed


func _on_Player_game_over():
	game_over = true
	get_node("GameOverAudio").play()
	
	# Hide the Score and show the Game Over screen
	get_node("GameOverContainer").visible = true
	get_node("ScoreContainer").visible = false
	get_node("GameOverContainer/HBoxContainer/Score").text = str(score)
