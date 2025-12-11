extends MarginContainer

@onready var saving: Control = $"../../Saving"
@onready var loading: Control = $"../../Loading"

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	Dialogic.VAR.variable_changed.connect(_on_variable_changed)
	var Heroine_1 = Dialogic.VAR.get_variable('Love_points.Heroine_1')
	var Heroine_2 = Dialogic.VAR.get_variable('Love_points.Heroine_2')
	var Heroine_3 = Dialogic.VAR.get_variable('Love_points.Heroine_3')
	print('女一好感：',Heroine_1,'\n女二好感：',Heroine_2,'\n女三好感：',Heroine_3)

func _on_variable_changed(info: Dictionary) -> void:
	var variable_name = info.variable
	var new_value = info.new_value
	if variable_name == 'Love_points.Heroine_1':
		print('女一好感现在为', new_value)
	elif variable_name == 'Love_points.Heroine_2':
		print('女二好感现在为', new_value)
	elif variable_name == 'Love_points.Heroine_3':
		print('女三好感现在为', new_value)


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
	

func _on_system_pressed() -> void:
	print('系统')



func _on_qload_pressed() -> void:
	print('快速加载')
	Dialogic.Save.load('slot_Q')



func _on_load_pressed() -> void:
	print('加载')
	loading.show()



func _on_qsave_pressed() -> void:
	print('快速保存')
	Dialogic.Save.save('slot_Q')



func _on_save_pressed() -> void:
	print('保存')
	Dialogic.Save.take_thumbnail() #截图
	saving.show()



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
