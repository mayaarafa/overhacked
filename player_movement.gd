extends CharacterBody3D

const SPEED = 5.0;
const JUMP_VELOCITY = 4.5;
const DASH_SPEED = 8.00;
const DASH_COOLDOWN = 3;
const DASH_DURATION = 0.5;
var can_dash = true;
var is_dashing = false;
@onready var dash_cooldown: Timer = get_node("DashCooldown");
@onready var dash_duration: Timer = get_node("DashDuration");

func _ready() -> void:
	dash_cooldown.wait_time = DASH_COOLDOWN;
	dash_duration.wait_time = DASH_DURATION;
	
func _physics_process(delta: float) -> void:		

	# Add the gravity.
	if not is_on_floor():
		velocity += get_gravity() * delta

	# handle dash.
	if can_dash == false && is_dashing == true && dash_duration.is_stopped():
		print("dash cooldown start");
		is_dashing = false;
		dash_cooldown.start();
		
	if is_dashing == false && can_dash == false && dash_cooldown.is_stopped():
		print("dash cooldown ended");
		can_dash = true;
	
	# Handle jump.
	if Input.is_action_just_pressed("ui_accept") and is_on_floor():
		velocity.y = JUMP_VELOCITY

	# Get the input direction and handle the movement/deceleration.
	# As good practice, you should replace UI actions with custom gameplay actions.
	var input_dir := Input.get_vector("ui_left", "ui_right", "ui_up", "ui_down")
	var direction := (transform.basis * Vector3(input_dir.x, 0, input_dir.y)).normalized()
		
	if direction && !is_dashing:
		velocity.x = direction.x * SPEED
		velocity.z = direction.z * SPEED
		
	elif !is_dashing:
		velocity.x = move_toward(velocity.x, 0, SPEED)
		velocity.z = move_toward(velocity.z, 0, SPEED)

	# handle dash movement
	if Input.is_action_just_pressed("dash") && can_dash:
		print("dash attempted");
		can_dash = false;
		is_dashing = true;
		dash_duration.start();
		velocity.x = direction.x * DASH_SPEED; 
		velocity.z = direction.z * DASH_SPEED;
		
	elif Input.is_action_just_pressed("dash") && !can_dash:
		print("dash on cd");
	

	move_and_slide()
