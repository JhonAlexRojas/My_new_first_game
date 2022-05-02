extends Control


func _ready():
	show()
	yield($Tween, "tween_completed")
	hide()
	yield($Tween, "tween_completed")
	get_tree().call_deferred("change_scene", "res://Scenes/Menu.tscn")


func show():
	$Tween.interpolate_property(self, "modulate", Color.black, Color.white, 3, Tween.TRANS_BACK, Tween.EASE_IN_OUT)
	$Tween.start()


func hide():
	$Tween.interpolate_property(self, "modulate", Color.white, Color.black, 3, Tween.TRANS_BACK, Tween.EASE_IN_OUT)
	$Tween.start()
