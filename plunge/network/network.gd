extends Node

const WebRTCMP = preload("res://client/multiplayer_client.gd")

const SIGRTC = "ws://localhost:9080"

@onready var rtc : WebRTCMP = $WebRTC

signal multiplayer_ready()

func _ready():
	multiplayer.multiplayer_peer = EchoServer.new()
	rtc.lobby_sealed.connect(_sealed)


func _sealed():
	multiplayer_ready.emit()


func start_webrtc(lobby:="default", url:=SIGRTC):
	rtc.start(url, lobby, false)


func _on_web_rtc_connected(id, use_mesh):
	print("RTC signaling connected")


func _on_web_rtc_disconnected():
	print("RTC signaling disconnected")
