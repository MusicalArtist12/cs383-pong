class_name Paddle extends StaticBody2D

var dist: float
var moveBy: float
var useAI: bool
var upAction: StringName
var downAction: StringName
var rect: ColorRect
var collisionShape: CollisionShape2D

const PADDLE_WIDTH: int = 20
const PADDLE_HEIGHT: int = 120

func ai(delta: float):
	# figure out what the closest ball is to the goal
	if !get_parent().balls.is_empty():
		var unset = true
		var ballPos = position

		for ball in get_parent().balls:
			# closest ball heading towards the paddle
			if (unset || abs(ball.position.x - position.x) < abs(ballPos.x - position.x) ) and 1 == sign(abs((ball.position.x) - position.x) - abs((ball.position.x + ball.dir.x) - position.x)):
				unset = false
				ballPos = ball.position

		dist = (position.y - ballPos.y)


	if abs(dist) > get_parent().PADDLE_SPEED * delta:
		moveBy = get_parent().PADDLE_SPEED * delta * (dist / abs(dist)) 
	else:
		moveBy = dist

	position.y -= moveBy 

func _init(posx : int, up: StringName, down: StringName) -> void:
	upAction = up
	downAction = down

	# give the paddle some color
	rect = ColorRect.new()
	rect.size.x = PADDLE_WIDTH
	rect.size.y = PADDLE_HEIGHT
	rect.position.x = -PADDLE_WIDTH/2.0
	rect.position.y = -PADDLE_HEIGHT/2.0
	rect.set_color(Color(1, 1, 1, 1))
	add_child(rect)

	# give it collision detection
	collisionShape = CollisionShape2D.new()
	collisionShape.shape = RectangleShape2D.new()
	collisionShape.shape.set_size(Vector2(PADDLE_WIDTH, PADDLE_HEIGHT))
	add_child(collisionShape)
	
	useAI = false

	position.x = posx
	position.y = Settings.winSize.y/2
	

func _process(delta: float) -> void:
	if useAI:
		ai(delta)
	
	else:
		if Input.is_action_pressed(upAction):
			position.y -= get_parent().PADDLE_SPEED * delta

		if Input.is_action_pressed(downAction):
			position.y += get_parent().PADDLE_SPEED * delta


	position.y = clamp(position.y, 0 + PADDLE_HEIGHT/2 + 10, Settings.winSize.y - PADDLE_HEIGHT/2 - 10)
