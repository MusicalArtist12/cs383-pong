extends Node2D

var score := [0, 0]
const PADDLE_SPEED : int = 500

func _ready() -> void:
	$leftPlayer.useAI = false
	$rightPlayer.useAI = true
	
	$HUD/RightScore.text = str(score[1])
	$HUD/LeftScore.text = str(score[0])
		
	while ($HUD/RightScore.text.length() < 2):
		$HUD/RightScore.text = '0' + $HUD/RightScore.text
	
	while ($HUD/LeftScore.text.length() < 2):
		$HUD/LeftScore.text = '0' + $HUD/LeftScore.text
		

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
