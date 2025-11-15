extends Control

var gameCenter: GameCenterManager

func _on_button_pressed() -> void:
	if ClassDB.class_exists("GameCenterManager"):
		var instance = ClassDB.instantiate("GameCenterManager")
		$auth_result.text = "Instantiated"
		instance.authentication_error.connect(func(error: String) -> void:
			$auth_result.text = error
			)
		instance.authentication_result.connect(func(status: bool) -> void:
			if status:
				$auth_state.text = "Authenticated"
			else:
				$auth_state.text = "Not Authenticated"
			)
		instance.authenticate()
	else:
		$auth_result.text = "GameCenterManager was not found"
