extends Node
class_name PlayerControls

signal triggered(index: int)

class Axis:
	var negative : StringName
	var positive : StringName
	var value := 0.0

	func _init(negative: StringName, positive: StringName):
		self.negative = negative
		self.positive = positive

	func update():
		value = Input.get_axis(negative, positive)
		return value


var _axises := []
var _triggers := []

var player := 1 :
	set(value):
		player = value
		set_multiplayer_authority(player, true)

@export var trigger_count := 3
@export var axis_count := 2

var axies := PackedFloat32Array()
var triggers := PackedByteArray()

func _init():
	for i in range(trigger_count):
		_triggers.push_back(StringName("trigger_%d" % i))
	triggers.resize(trigger_count)
	triggers.fill(0)

	for i in range(axis_count):
		_axises.push_back(Axis.new("axis_%d-" % i, "axis_%d+" % i))
	axies.resize(axis_count)
	axies.fill(0.0)


func _ready():
	set_multiplayer_authority(player, true)


func update_controls():
	if multiplayer.get_unique_id() != player:
		return

	for i in range(axis_count):
		axies[i] = _axises[i].update()

	for i in range(trigger_count):
		trigger.rpc(i, 1 if Input.is_action_just_pressed(_triggers[i]) else 0)

@rpc(call_local)
func trigger(idx: int, value: int):
	if idx < 0 or idx >= triggers.size():
		return
	if value and not triggers[idx]:
		triggered.emit(idx)
	triggers[idx] = value
