extends StaticBody2D

var winHeight : int
var pHeight : int

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	winHeight = get_viewport_rect().size.y

	
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if Input.is_action_pressed("ui_up"):
		position.y -= get_parent().PADDLE_SPEED * delta

	if Input.is_action_pressed("ui_down"):
		position.y += get_parent().PADDLE_SPEED * delta

	position.y = clamp(position.y, -winHeight / 2.0, winHeight / 2.0);
