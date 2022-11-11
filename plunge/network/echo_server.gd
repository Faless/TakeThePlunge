extends MultiplayerPeerExtension
class_name EchoServer

func _get_unique_id():
	return 1

func _get_connection_status():
	return CONNECTION_CONNECTED

func _is_server():
	return true

func _poll():
	pass

func _get_available_packet_count():
	return 0
