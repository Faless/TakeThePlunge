extends MultiplayerSpawner

const Ship = preload("res://game/ship/ship.tscn")

# Called when the node enters the scene tree for the first time.
func _spawn_custom(data) -> Node:
	if typeof(data) != TYPE_INT:
		return
	var node = Ship.instantiate()
	node.player = data
	node.name = str(data)
	return node
