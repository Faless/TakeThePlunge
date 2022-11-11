extends Node

func _ready():
	multiplayer.multiplayer_peer = EchoServer.new()
