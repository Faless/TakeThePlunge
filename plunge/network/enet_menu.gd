extends Control

signal start(host: String)

func _on_host_pressed():
	start.emit("")


func _on_connect_pressed():
	var txt : String = $Options/Remote.text
	if txt == "":
		push_error("Need a remote to connect to.")
		print("Need a remote to connect to.")
		return
	start.emit(txt)
