extends Node2D


signal game_over


const GRAVITY = 0.14 * 60.0
var dy = 0.0 # Displacement in the Y axis
var game_over = false
#var stop = true


func _ready():
	position = Vector2(32, 60)
	yield(get_tree().create_timer(1.1), "timeout")
	Global.stop = false


func countdown():
	yield(get_tree().create_timer(3.1), "timeout")
	Global.stop = false


func _process(_delta):
	if not Global.stop:
		
		# Update Player
		if not game_over:
			check_hit()
			move_player()
	draw_player()

func _physics_process(delta):
	if not Global.stop:
		dy += GRAVITY
		
		# Move to new position
		if not game_over:
			position.y += dy * delta


func move_player():
	# Jump
	if Input.is_action_just_pressed("ui_accept"):
		dy -= 4.0 * 60.0
		$AudioStreamPlayer.play()


func draw_player():
	if game_over:
		$AnimatedSprite.play("dead")
	elif dy < 0:
		$AnimatedSprite.play("rise")
	else:
		$AnimatedSprite.play("fall")


func check_hit():
	var cave = get_node("../Cave").cave
	for i in range(position.x / 2, (position.x / 2) + 3):
		if cave[i]["top"] > position.y or cave[i]["btm"] < position.y + 7:
			game_over = true
			emit_signal("game_over")
			Global.stop = true
