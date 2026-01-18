extends Node3D

@export var item_scene: PackedScene
@export var spawn_on_ready := true

@onready var spawn_point: Node3D = $SpawnPoint
var current_item: Node3D = null

func _ready() -> void:
	if spawn_on_ready:
		call_deferred("spawn_item")


func spawn_item() -> void:
	if current_item != null:
		return
	if item_scene == null:
		push_error("item_scene NOT assigned on Table")
		return

	var item = item_scene.instantiate()

	# Add after the tree finishes setting up
	get_tree().current_scene.add_child.call_deferred(item)

	# Also defer setting position until it's inside tree
	item.call_deferred("set_global_position", spawn_point.global_position)

	current_item = item
