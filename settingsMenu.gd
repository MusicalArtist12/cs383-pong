extends Control

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	if Settings.leftPlayerAI:
		$leftPlayer/enableAI.text = "Disable AI"
	else:
		$leftPlayer/enableAI.text = "Enable AI"

	if Settings.rightPlayerAI:
		$rightPlayer/enableAI.text = "Disable AI"
	else:
		$rightPlayer/enableAI.text = "Enable AI"

	

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta: float) -> void:
	if Input.is_action_just_pressed("pause"):
		queue_free()

func _on_back_button_pressed() -> void:
	queue_free()

func _on_leftPlayer_enable_ai_pressed() -> void:
	Settings.leftPlayerAI = !Settings.leftPlayerAI 

	if Settings.leftPlayerAI:
		$leftPlayer/enableAI.text = "Disable AI"
	else:
		$leftPlayer/enableAI.text = "Enable AI"

func _on_rightPlayer_enable_ai_pressed() -> void:
	Settings.rightPlayerAI = !Settings.rightPlayerAI 
	if Settings.rightPlayerAI:
		$rightPlayer/enableAI.text = "Disable AI"
	else:
		$rightPlayer/enableAI.text = "Enable AI"
