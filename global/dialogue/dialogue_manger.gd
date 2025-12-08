extends Control

@export_group('UI')
@export var character_name_text: RichTextLabel ##角色名称文本框
@export var text_label: RichTextLabel ##对话内容文本框
@export var avatar_box: TextureRect ##角色头像

@export_group('对话')
@export var main_dialogue: DialogueGroup ##管理对话组

var dialogue_index: int = 0 #计数器，记录当前是第几条对话
var typing_tween: Tween #打字机动画

func _ready() -> void:
	display_dialogue() 

func display_dialogue():
	#防止超出最大对话数量
	if dialogue_index >= len(main_dialogue.dialogue_list): 
		return
	
	var dialogue :Dialogue = main_dialogue.dialogue_list[dialogue_index]#初始化
	
	#打字机显示对话内容
	if typing_tween and typing_tween.is_running():
		typing_tween.kill()
		text_label.text = dialogue.content
		dialogue_index += 1
	else :
		typing_tween = get_tree().create_tween()
		text_label.text = ''
		for character in dialogue.content:
			typing_tween.tween_callback(append_character.bind(character)).set_delay(0.05)
		typing_tween.tween_callback(func(): dialogue_index += 1)
		
		character_name_text.text = dialogue.character_name #显示角色名
	
	

#打字机函数
func append_character(character: String):
	text_label.text += character

#点击对话框时前进到下一条对话
func _on_click(event: InputEvent) -> void:
	if event is InputEventMouseButton and event.button_index == MOUSE_BUTTON_LEFT and event.pressed:
		display_dialogue()


func _on_auto_button_pressed() -> void:
	print('自动模式启用')
