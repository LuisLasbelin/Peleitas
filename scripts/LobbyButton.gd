class_name LobbyButton
extends Control


var lobby_id
var join_lobby : Callable


func _ready():
	%LobbyName.text = str(lobby_id)


func set_data(_lobby_id, _join_lobby : Callable):
	self.lobby_id = _lobby_id
	self.join_lobby = _join_lobby


func _on_join_lobby_pressed():
	join_lobby.call(lobby_id)
