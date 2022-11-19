extends Control

signal start(lobby: String, url: String)

var url : String :
	get:
		return $Options/URL/LineEdit.text

func write(msg: String):
	var c = $Log as TextEdit
	c.insert_line_at(c.get_line_count()-1, msg)


func set_code(code: String):
	$Options/Room.text = code


func _on_find_pressed():
	write("Searching game...")
	start.emit("default", url)


func _on_join_pressed():
	var room = $Options/Room.text
	if room == "":
		write("ERROR: Need a game code to join")
		return
	write("Joining game '%s'..." % room)
	start.emit(room, url)


func _on_create_pressed():
	write("Creating game...")
	start.emit("", url)
