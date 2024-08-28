class_name Paddle extends StaticBody2D

var ballPos: Vector2
var dist: float
var moveBy: float
var pHeight: float
var useAI: bool
var upAction: StringName
var downAction: StringName

var rect: ColorRect
var collisionShape: CollisionShape2D

const PADDLE_WIDTH: int = 20
const PADDLE_HEIGHT: int = 120

func ai(delta: float):
	if !get_parent().balls.is_empty():
		ballPos = get_parent().balls[0].position

		for ball in get_parent().balls:
			if abs(ball.position.x - position.x) < abs(ballPos.x - position.x) and abs(rad_to_deg((position.angle_to(ball.position)))) < 80:
				ballPos = ball.position

		dist = (position.y - ballPos.y)
	else:
		ballPos.y = 0.0

	if abs(dist) > get_parent().PADDLE_SPEED * delta:
		moveBy = get_parent().PADDLE_SPEED * delta * (dist / abs(dist)) 
	else:
		moveBy = dist

	position.y -= moveBy 

func _init(posx : int, up: StringName, down: StringName) -> void:
	upAction = up
	downAction = down

	rect = ColorRect.new()
	rect.size.x = PADDLE_WIDTH
	rect.size.y = PADDLE_HEIGHT
	rect.position.x = -PADDLE_WIDTH/2.0
	rect.position.y = -PADDLE_HEIGHT/2.0
	rect.set_color(Color(1, 1, 1, 1))
	add_child(rect)

	collisionShape = CollisionShape2D.new()
	collisionShape.shape = RectangleShape2D.new()
	collisionShape.shape.set_size(Vector2(PADDLE_WIDTH, PADDLE_HEIGHT))
	add_child(collisionShape)
	
	useAI = false

	position.x = posx
	position.y = Settings.winSize.y/2
	

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pHeight = rect.get_size().y

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if useAI:
		ai(delta)
	
	else:
		if Input.is_action_pressed(upAction):
			position.y -= get_parent().PADDLE_SPEED * delta

		if Input.is_action_pressed(downAction):
			position.y += get_parent().PADDLE_SPEED * delta

	position.y = clamp(position.y, 0 + pHeight/2 + 10, Settings.winSize.y - pHeight/2 - 10)
