extends Control
	
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta: float) -> void:
	if Settings.rightPlayerAI:
		$rightPlayer/enableAI.text = "Disable AI"
	else:
		$rightPlayer/enableAI.text = "Enable AI"

	if Settings.leftPlayerAI:
		$leftPlayer/enableAI.text = "Disable AI"
	else:
		$leftPlayer/enableAI.text = "Enable AI"
	
	if Input.is_action_just_pressed("pause"):
		# remove from rendering
		queue_free()

func _on_back_button_pressed() -> void:
	queue_free()

func _on_leftPlayer_enable_ai_pressed() -> void:
	Settings.leftPlayerAI = !Settings.leftPlayerAI 


func _on_rightPlayer_enable_ai_pressed() -> void:
	Settings.rightPlayerAI = !Settings.rightPlayerAI 
