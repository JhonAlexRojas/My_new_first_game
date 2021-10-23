extends Node2D


signal game_over


const GRAVITY = 0.2
var dy = 0.0 # Displacement in the Y axis
var game_over = false


func _ready():
	position = Vector2(32, 60)


func _process(_delta):
	draw_player()
	
	# Update Player
	if not game_over:
		move_player()
		check_hit()


func move_player():
	dy += GRAVITY

	# Jump
	if Input.is_action_just_pressed("ui_accept"):
		dy -= 5
		$AudioStreamPlayer.play()

	# Move to new position
	position.y += dy


func draw_player():
	if game_over:
		$AnimatedSprite.play("dead")
	elif dy < 0:
		$AnimatedSprite.play("rise")
	else:
		$AnimatedSprite.play("fall")


func check_hit():
	var cave = get_node("../Cave").cave
	for i in range(position.x, position.x + 7):
		if cave[i]["top"] > position.y or cave[i]["btm"] < position.y + 7:
			game_over = true
			emit_signal("game_over")
