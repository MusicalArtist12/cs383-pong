extends Node2D

var rightPlayer : Paddle
var leftPlayer : Paddle

var score := [0, 0]
const PADDLE_SPEED : int = 500

func _ready() -> void:
	rightPlayer = Paddle.new(510, "rightPlayerUp", "rightPlayerDown")
	rightPlayer.useAI = true
	
	leftPlayer = Paddle.new(-510, "leftPlayerUp", "leftPlayerDown")

	add_child(leftPlayer)
	add_child(rightPlayer)
	
	$HUD/RightScore.text = str(score[1])
	$HUD/LeftScore.text = str(score[0])
		
	while ($HUD/RightScore.text.length() < 2):
		$HUD/RightScore.text = '0' + $HUD/RightScore.text
	
	while ($HUD/LeftScore.text.length() < 2):
		$HUD/LeftScore.text = '0' + $HUD/LeftScore.text
	
func _process(delta: float) -> void:
	if Input.is_action_just_pressed("pause"):
		var a = 1	

func _on_ball_timer_timeout():
	$ball.new_ball()

func _on_score_left_body_entered(body: Node2D) -> void:
	score[1] += 1
	$HUD/RightScore.text = str(score[1])
		
	while ($HUD/RightScore.text.length() < 2):
		$HUD/RightScore.text = '0' + $HUD/RightScore.text
	
	$BallTimer.start()

func _on_score_right_body_entered(body: Node2D) -> void:
	score[0] += 1
	$HUD/LeftScore.text = str(score[0])
	
	while ($HUD/LeftScore.text.length() < 2):
		$HUD/LeftScore.text = '0' + $HUD/LeftScore.text
	
	$BallTimer.start()
