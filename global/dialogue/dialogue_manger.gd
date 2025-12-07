extends Control

@export_group('UI')
@export var character_name_text: RichTextLabel #角色名称文本框
@export var text_label: RichTextLabel #对话内容文本框
@export var avatar_box: TextureRect #角色头像

@export_group('对话')
@export var main_dialogue: DialogueGroup #管理对话组

var dialogue_index: int = 0 #计数器，记录当前是第几条对话

func _ready() -> void:
	display_dialogue() 

func display_dialogue():
	var dialogue :Dialogue = main_dialogue.dialogue_list[dialogue_index]#初始化
	
	character_name_text.text = dialogue.character_name #显示角色名
	text_label.text = dialogue.content #显示对话内容
	avatar_box.texture = dialogue.avatar #显示头像
	
	dialogue_index += 1
