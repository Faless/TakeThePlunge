extends MultiplayerSpawner

const ShipScene = preload("res://game/ship/ship.tscn")

func _spawn_custom(data) -> Node:
	if typeof(data) != TYPE_INT:
		return
	var node = ShipScene.instantiate()
	node.player = data
	node.position.x = (randi() % 10) - 20
	node.name = str(data)
	return node
