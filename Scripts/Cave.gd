extends Node2D


var speed = 1
var game_over = false
onready var cave = [{"top": 3, "btm": 124}] # Make Cave
const TOP = 45 # How low can the ceiling go
const BTM = 85 # How high can the floor get
onready var width = get_viewport().get_size_override().x


func _physics_process(_delta):
	if not game_over:
		update_cave()
		update() # Update CanvasItem


func update_cave():
	# Remove the back of the cave
	if len(cave) > speed:
		for _i in range(speed):
			cave.remove(0)
	
	# Add more cave
	while len(cave) <= width / 2:
		var col = {}
		var up = floor(rand_range(-3, 4))
		var down = floor(rand_range(-3, 4))
		col["top"] = clamp(cave[-1]["top"] + up, 3, TOP)
		col["btm"] = clamp(cave[-1]["btm"] + down, BTM, 124)
		cave.append(col)


func _draw(): # Draw in CanvaItem
	for i in range(len(cave)):
		draw_line(Vector2(i * 2, 0), Vector2(i * 2, cave[i]["top"]), Color.gray, 2)
		draw_line(Vector2(i * 2, 129), Vector2(i * 2, cave[i]["btm"]), Color.gray, 2)


func _on_Player_game_over():
	game_over = true
