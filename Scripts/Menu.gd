extends CanvasLayer


func _ready():
	get_node("CRT/ColorRect").visible = Global.crt_mode
	yield(get_tree().create_timer(0.5), "timeout")
	$AudioStreamPlayer.play()


func _process(_delta):
	if Input.is_action_just_pressed("ui_accept"):
		get_tree().call_deferred("change_scene", "res://Scenes/Level.tscn")
	elif Input.is_action_just_pressed("ui_exit"):
		get_tree().quit()


func _on_CRTButton_pressed():
	Global.crt_mode = not Global.crt_mode
	get_node("CRT/ColorRect").visible = Global.crt_mode
