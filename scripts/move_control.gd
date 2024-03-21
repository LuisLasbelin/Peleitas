extends Node2D

@export var speed : float = 1.0
var player_id : int
var player_name
var movement_vector : Vector2 = Vector2(0,0)


func set_data(_player_id, _player_name):
	self.player_id = _player_id
	player_name = _player_name


func _ready():
	$PlayerName.text = player_name


func _process(delta):
	set_process(get_multiplayer_authority() == multiplayer.get_unique_id())
	self.look_at(get_viewport().get_mouse_position())
	self.position += movement_vector * speed


func _unhandled_input(event):
	if player_id != multiplayer.get_unique_id():
		return
	var input_movement : Vector2 = Vector2(0,0)
	if event.is_action("right"): input_movement += Vector2(1, 0)
	if event.is_action("left"): input_movement -= Vector2(1, 0)
	if event.is_action("top"): input_movement -= Vector2(0, 1)
	if event.is_action("down"): input_movement += Vector2(0, 1)
	movement_vector = Vector2(
		clamp(movement_vector.x+input_movement.x, -1, 1), 
		clamp(movement_vector.y+input_movement.y, -1, 1)
		)
	print(movement_vector)
