class_name Paddle

extends StaticBody2D

var winHeight : int
var ballPos : Vector2
var dist : int
var moveBy: float
var pHeight : int
var useAI : bool
var enemyPos : Vector2

func ai(delta: float):
	ballPos = $"../ball".position

	if $"../rightPlayer".position != position:
		enemyPos = $"../rightPlayer".position
	else: 
		enemyPos = $"../leftPlayer".position
	
	dist = (position.y - ballPos.y) + (pHeight * enemyPos.normalized().y)
	

	if abs(dist) > get_parent().PADDLE_SPEED * delta:
		moveBy = get_parent().PADDLE_SPEED * delta * (dist / abs(dist)) 
	else:
		moveBy = dist


	position.y -= moveBy 

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	winHeight = get_viewport_rect().size.y
	pHeight = $ColorRect.get_size().y

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if useAI:
		ai(delta)
	
	else:
		if Input.is_key_pressed(KEY_W):
			position.y -= get_parent().PADDLE_SPEED * delta

		if Input.is_key_pressed(KEY_S):
			position.y += get_parent().PADDLE_SPEED * delta

	position.y = clamp(position.y, -winHeight / 2.0, winHeight / 2.0)
