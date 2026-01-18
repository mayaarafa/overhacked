extends Node3D

@export var item_scene: PackedScene
@export var spawn_on_ready := true

@onready var spawn_point: Node3D = $SpawnPoint
var current_item: Node3D = null

func _ready() -> void:
	print("Table ready")
	if spawn_on_ready:
		spawn_item()

func spawn_item() -> void:
	print("Spawning item on table")

	if current_item != null:
		print("Item already exists")
		return

	if item_scene == null:
		push_error("item_scene NOT assigned on Table")
		return

	var item = item_scene.instantiate()
	get_tree().current_scene.add_child(item)
	#item.global_position = spawn_point.global_position
	var cam := get_viewport().get_camera_3d()
	item.global_position = cam.global_position + (-cam.global_transform.basis.z * 2.0)

	current_item = item
