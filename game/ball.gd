class_name Ball extends CharacterBody2D

const MAX_Y_VECTOR = 0.6
const START_SPEED = 300
const ACCEL = 20
const MAX_SPLITS = 3
const MAX_SIZE = 20

var size = 20
var speed: int
var dir: Vector2
var splits: int = 0
var count = 0

# Children of this Node
var rect : ColorRect
var collisionShape : CollisionShape2D

func _init(d: Vector2, spl: int = 0):
	splits = spl
	dir = d

	size = MAX_SIZE - (MAX_SIZE / (MAX_SPLITS * 2.0)) * splits

	# create ball
	rect = ColorRect.new();
	rect.size.x = size
	rect.size.y = size
	rect.position.x = -size/2.0
	rect.position.y = -size/2.0
	rect.set_color(Color(1, 1, 1, 1))
	add_child(rect)

	# give it collision
	collisionShape = CollisionShape2D.new()
	collisionShape.shape = RectangleShape2D.new()
	collisionShape.shape.set_size(Vector2(size, size))
	add_child(collisionShape);

	# give it a position
	position.x = Settings.winSize.x/2
	position.y = Settings.winSize.y/2
	speed = START_SPEED

func _physics_process(delta: float) -> void:
	var collision = move_and_collide(dir * speed * delta)
	var collider
	if collision:
		collider = collision.get_collider()

		# Speed up the ball when hitting a paddle
		if collider is Paddle:
			speed += ACCEL
			dir = new_direction(collider)

		# Break up into two when hitting another ball
		elif collider is Ball and splits < MAX_SPLITS:
			# VERY IMPORTANT
			splits += 1

			var myBall = Ball.new(dir, splits)
			myBall.position = Vector2(position.x - (MAX_SIZE * 2 * sign(dir.x)), position.y + MAX_SIZE * 2)
			get_parent().add_ball(myBall)

			dir = dir.bounce(collision.get_normal())
		else:
			dir = dir.bounce(collision.get_normal())

	
func _process(_delta: float) -> void:
	size = MAX_SIZE - (MAX_SIZE / (MAX_SPLITS * 2.0)) * splits

	rect.size.x = size
	rect.size.y = size
	rect.position.x = -size/2.0
	rect.position.y = -size/2.0

	collisionShape.shape.set_size(Vector2(size, size))

	# set the color accordingly
	if count <= 0:
		rect.set_color(Color(1, 1, 1, 1))
	elif count == 1:
		rect.set_color(Color(0, 1, 0, 1))
	elif count == 2:
		rect.set_color(Color(1, 1, 0, 1))
	elif count == 3:
		rect.set_color(Color(1, 0, 0, 1))

# Balls bounce differently against paddles compared to other objects
func new_direction(collider):
	var ballY = position.y
	var padY = collider.position.y
	var dist = ballY - padY
	var newDir := Vector2()
	
	if dir.x > 0:
		newDir.x = -1
	else:
		newDir.x = 1
		
	newDir.y = (dist / (collider.PADDLE_HEIGHT / 2)) * MAX_Y_VECTOR
	
	return newDir.normalized()
