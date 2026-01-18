extends Node3D

const ITEMSCODES = ['filament', 'source', 'matcha', 'coffee', 'tea', '3D', 'library', 'code block'];;
var project_size;
var order = [];
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	project_size = randi() % 5;
	for i in range(project_size):
		var rand_item = get_rand_item_not_in_array(order);
		order.append(rand_item);

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass

func get_rand_item_not_in_array(pre_existing: Array = []):
	# If all items are already used, return null
	if pre_existing.size() >= ITEMSCODES.size():
		return null
	var item = ITEMSCODES.pick_random()
	while pre_existing.has(item):
		item = ITEMSCODES.pick_random()
	return item
