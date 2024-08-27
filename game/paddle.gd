class_name Paddle extends StaticBody2D

var winHeight : int
var ballPos : Vector2
var dist : int
var moveBy: float
var pHeight : int
var useAI : bool
var upAction : StringName
var downAction : StringName

var rect : ColorRect
var collisionShape : CollisionShape2D

func ai(delta: float):
	ballPos = $"../ball".position

	dist = (position.y - ballPos.y)

	if abs(dist) > get_parent().PADDLE_SPEED * delta:
		moveBy = get_parent().PADDLE_SPEED * delta * (dist / abs(dist)) 
	else:
		moveBy = dist

	position.y -= moveBy 

func _init(posx : int, up: StringName, down: StringName) -> void:
	upAction = up
	downAction = down

	
	rect = ColorRect.new()
	rect.size.x = 20
	rect.size.y = 80
	rect.position.x = -10
	rect.position.y = -40
	rect.set_color(Color(1, 1, 1, 1))
	add_child(rect)

	collisionShape = CollisionShape2D.new()
	collisionShape.shape = RectangleShape2D.new()
	collisionShape.shape.set_size(Vector2(20, 80))
	add_child(collisionShape)
	
	useAI = false

	position.x = posx
	position.y = 0
	

# Called when the node enters the scene tree for the first time.
func _ready() -> void:

	
	winHeight = get_viewport_rect().size.y
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

	position.y = clamp(position.y, -winHeight / 2.0, winHeight / 2.0)
