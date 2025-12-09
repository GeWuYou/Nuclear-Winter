extends MarginContainer


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
	

func _on_system_pressed() -> void:
	print('系统')



func _on_qload_pressed() -> void:
	print('快速加载')



func _on_load_pressed() -> void:
	print('加载')



func _on_qsave_pressed() -> void:
	print('快速保存')



func _on_save_pressed() -> void:
	print('保存')



func _on_next_pressed() -> void:
	print('跳转到下个选项')



func _on_return_pressed() -> void:
	print('跳转到上个选项')



func _on_log_pressed() -> void:
	print('历史记录')



func _on_skip_pressed() -> void:
	print('快进模式')



func _on_auto_pressed() -> void:
	print('自动模式')
