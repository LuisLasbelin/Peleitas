extends Control

@export var lobby_button : PackedScene


func _ready():
	%Start.show()
	%Lobby.hide()


func change_to_lobby():
	%Start.hide()
	%Lobby.show()
	synchronize_players_list()


func change_to_start():
	%Start.show()
	%Lobby.hide()
	synchronize_lobbies_list()


func synchronize_lobbies_list():
	print(multiplayer.get_unique_id(), " DEBUG: synchronizing lobbies list.")
	for child in %LobbiesList.get_children():
		child.queue_free()
	var lobbies = []
	for player_id in Lobby.players:
		# Create an array of all lobbies
		var lobby_id = Lobby.players[player_id].lobby
		if str(lobby_id) != "0" and not lobbies.has(lobby_id):
			# Add lobby name to the list
			lobbies.append(lobby_id)
	print(multiplayer.get_unique_id(), " DEBUG: creating lobbies: ", lobbies)
	for lobby in lobbies:
		var new_btn = lobby_button.instantiate()
		new_btn.set_data(lobby, join_lobby)
		%LobbiesList.add_child(new_btn)
	# Update players text lists
	synchronize_players_list()

func synchronize_players_list():
	for child in %PlayersList.get_children():
		child.queue_free()
	var players = []
	var local_player = multiplayer.get_unique_id()
	for player_id in Lobby.players:
		if Lobby.players[player_id].lobby != "0" and Lobby.players[player_id].lobby == Lobby.players[local_player].lobby:
			players.append(player_id)
	for p in players:
		var new_p = Label.new()
		new_p.text = str(Lobby.players[p]["name"])
		%PlayersList.add_child(new_p)
	print(multiplayer.get_unique_id(), " DEBUG: players in lobby: ", players)

# A player joins a lobby
func join_lobby(lobby_id):
	Lobby.join_lobby(lobby_id)
	change_to_lobby()
