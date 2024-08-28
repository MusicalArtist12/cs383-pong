extends Node2D

var rightPlayer : Paddle
var leftPlayer : Paddle
var balls : Array
var score := [0, 0]

const PADDLE_SPEED : int = 800

func random_direction():
	var new_dir := Vector2()
	new_dir.x = [1, -1].pick_random()
	new_dir.y = randf_range(-1.0, 1.0)
	return new_dir.normalized()



func _ready() -> void:
	balls = Array([], TYPE_OBJECT, "Node", Ball)
	
	rightPlayer = Paddle.new(int(Settings.winSize.x-20.0), "rightPlayerUp", "rightPlayerDown")
	leftPlayer = Paddle.new(20, "leftPlayerUp", "leftPlayerDown")

	add_child(leftPlayer)
	add_child(rightPlayer)

	$HUD/RightScore.text = str(score[1])
	$HUD/LeftScore.text = str(score[0])
		
	while ($HUD/RightScore.text.length() < 2):
		$HUD/RightScore.text = '0' + $HUD/RightScore.text
	
	while ($HUD/LeftScore.text.length() < 2):
		$HUD/LeftScore.text = '0' + $HUD/LeftScore.text
	
func _process(_delta: float) -> void:
	if Input.is_action_just_pressed("pause"):
		get_tree().change_scene_to_file("res://main_menu.tscn")

	rightPlayer.useAI = Settings.rightPlayerAI
	leftPlayer.useAI = Settings.leftPlayerAI


	if balls.is_empty():
		balls.append(Ball.new(random_direction()))
		balls.back().count = -1
		add_child(balls.back())

func _on_score_left_body_entered(body: Node2D) -> void:
	if body is Ball:
		score[1] += 1
		$HUD/RightScore.text = str(score[1])
			
		while ($HUD/RightScore.text.length() < 2):
			$HUD/RightScore.text = '0' + $HUD/RightScore.text

		balls.erase(body)
		body.queue_free()

func _on_score_right_body_entered(body: Node2D) -> void:
	if body is Ball:
		score[0] += 1

		$HUD/LeftScore.text = str(score[0])
		
		while ($HUD/LeftScore.text.length() < 2):
			$HUD/LeftScore.text = '0' + $HUD/LeftScore.text
		

		balls.erase(body)
		body.queue_free()


func _on_incrementer_body_entered(body: Node2D) -> void:
	if body is Ball:
		if body.count < 4:
			body.count += 1

		if body.count == 4:
			body.count = 0
			balls.append(Ball.new(body.dir))
			balls.back().position = Vector2(body.position.x - 40 * sign(body.dir.x), body.position.y - 40 * sign(body.dir.y))
			balls.back().count = -1
			call_deferred("add_child", balls.back())
