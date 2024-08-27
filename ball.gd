extends CharacterBody2D


const START_SPEED = 300.0
const ACCEL = 50
var speed : int
var dir : Vector2

var win_size : Vector2

func _ready():
	win_size = get_viewport_rect().size

func random_direction():
	var new_dir := Vector2()
	new_dir.x = [1, -1].pick_random()
	new_dir.y = randf_range(-1.0, 1.0)
	return new_dir.normalized()
	


func new_ball():
	# randomize start position and direction
	position.x = 0
	position.y = randi_range(200, -200)
	dir = random_direction()
	speed = START_SPEED

func _physics_process(delta: float) -> void:
	move_and_collide(dir * speed * delta)
