extends Control


signal countdownout
var time = 0.0


func _ready():
	$CountdownTimer.start()


func _process(delta):
	$Label.text = str(int($CountdownTimer.time_left))


func _on_CountdownTimer_timeout():
	emit_signal("countdownout")
	visible = false
