extends Node3D

@export var item_id := "unknown"   # "item name"
@export var stackable := false

var holder: Node3D = null

func set_world_position(pos: Vector3) -> void:
	holder = null
	global_position = pos

func attach_to(node: Node3D) -> void:
	holder = node
	reparent(node)
	position = Vector3.ZERO

func detach_to(world: Node) -> void:
	reparent(world)
	holder = null
