extends Control


func _ready():
	%Start.show()
	%Lobby.hide()


func change_to_lobby():
	%Start.hide()
	%Lobby.show()


func change_to_start():
	%Start.show()
	%Lobby.hide()


func synchronize_lobbies_list():
	print("DEBUG: synchronizing lobbies list.")
	for child in %LobbiesList.get_children():
		child.queue_free()
	var lobbies = []
	for player_id in Lobby.players:
		# Create an array of all lobbies
		var lobby_id = Lobby.players[player_id].lobby
		print(lobby_id)
		if str(lobby_id) != "0" and not lobbies.has(lobby_id):
			# Add lobby name to the list
			lobbies.append(lobby_id)
	print("DEBUG: creating lobbies: ", lobbies)
	for lobby in lobbies:
		var new_btn = Button.new()
		new_btn.text = str(lobby)
		%LobbiesList.add_child(new_btn)
