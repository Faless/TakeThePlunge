@tool
extends EditorPlugin

class PlungerGizmo extends EditorNode3DGizmoPlugin:

	var gizmos := {}

	func _can_be_hidden():
		return false

	func _get_gizmo_name():
		return get_class()

	func _redraw(gizmo: EditorNode3DGizmo):
		var mesh := PrismMesh.new()
		var mat  := StandardMaterial3D.new()
		gizmo.clear()
		mat.albedo_color = Color.RED
		mesh.size *= .1
		gizmo.add_mesh(mesh, mat)

	func _create_gizmo(for_node_3d: Node3D):
		var plunger := for_node_3d as Plunger
		if plunger == null:
			return null
		return EditorNode3DGizmo.new()


var plunger_gizmo := PlungerGizmo.new()

func _enter_tree():
	add_node_3d_gizmo_plugin(plunger_gizmo)


func _exit_tree():
	remove_node_3d_gizmo_plugin(plunger_gizmo)
