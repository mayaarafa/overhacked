extends Node3D

# FSM for interactions
# generate order
# loop 1
# player comes close with item
# check if right item
# if so display check mark
# player places item
# sets equivalent dictionary to true
# check if all dictionary entries are true
# if not - loop 1
# if yes:
# start here*
# generate random order_cooldown in range
# set on_cooldown to true
# Remove order - done
# display no text on project_order
# wait for cooldown timer to finish
# #generate new order

const ITEMSCODES = ['filament', 'source', 'matcha', 'coffee', 'tea', '3D', 'library', 'code block'];;
var RNG = RandomNumberGenerator.new();
signal dictionary_changed
var order_cooldown;
var on_cooldown;
var project_size;
var order = {};
@onready var cooldown: Timer = get_node("order_generation_cooldown");

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	begin_cooldown(true);
	

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if (on_cooldown && cooldown.is_stopped()):
		on_cooldown = false;
		
	

func get_rand_item_not_in_array(pre_existing: Dictionary = {}):
	# If all items are already used, return null
	if pre_existing.size() >= ITEMSCODES.size():
		return null
	var item = ITEMSCODES.pick_random()
	while pre_existing.has(item):
		item = ITEMSCODES.pick_random()
	return item
	
func generate_new_order():
	order = {}
	project_size = randi() % 5;
	for i in range(project_size):
		var rand_item = get_rand_item_not_in_array(order);
		order[rand_item] = false;
	print(order);

func begin_cooldown(flag: bool = false):
	var random_int;
	set_dictionary({});
	if (true):
		random_int = RNG.randi_range(0, 21);
	else:
		random_int = RNG.randi_range(15, 46);
	cooldown.wait_time = random_int;
	cooldown.start();
	on_cooldown = true;

func set_dictionary(new_dict):
	order = new_dict;
	var text_project_order = get_node("text_project_order");
	text_project_order.update_dict(order);
	
