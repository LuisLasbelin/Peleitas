extends Node2D

@onready var spawner : MultiplayerSpawner = $MultiplayerSpawner
@export var player_scene : PackedScene

# Called when the node enters the scene tree for the first time.
func _ready():
	var local_player_id = multiplayer.get_unique_id()
	for player_id in Lobby.players:
		if Lobby.players[player_id].lobby == Lobby.players[local_player_id].lobby:
			# Spawn a new remote
			var p = player_scene.instantiate()
			p.set_data(player_id, Lobby.players[player_id].name)
			p.name = str(player_id)
			$Spawn.add_child(p, true)
