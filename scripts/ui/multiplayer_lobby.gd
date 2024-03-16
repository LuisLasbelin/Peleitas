extends Node

func _ready():
	# Preconfigure game.
	Lobby.player_loaded.rpc_id(1) # Tell the server that this peer has loaded.


# Called only on the server.
func start_game():
	# All peers are ready to receive RPCs in this scene.
	pass


func check_name() -> bool:
	if %NameInput.text.length() > 20 or %NameInput.text.length() < 1:
		%NameInputLabel.text = "Name must be less than 20 letters."
		return false
	# If the name is correct then enter
	%NameInputLabel.text = ""
	Lobby.player_info["name"] = %NameInput.text
	return true


func _on_create_pressed():
	if check_name():
		# Create a new lobby to let players connect
		Lobby.create_lobby()
		%StartLobby.change_to_lobby()
