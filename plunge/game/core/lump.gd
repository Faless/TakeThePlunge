extends RigidBody3D
class_name CoreLump

var lifetime := 5.0


func _ready():
	if not is_zero_approx(lifetime) and multiplayer.is_server():
		$Lifetime.wait_time = lifetime
		$Lifetime.start()


func _on_lifetime_timeout():
	queue_free()
