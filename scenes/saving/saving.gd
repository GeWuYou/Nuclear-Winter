extends Control

@onready var tab_container: TabContainer = $TabContainer
@onready var page: Label = $VBoxContainer/HBoxContainer/Page
@onready var saving: Control = $"."

# 存档按钮数组，按页面组织
var save_pages: Array[Array] = []  # 每个元素是一个页面的按钮数组
var total_buttons_per_page: int = 10
var total_pages: int = 6
var current_slot_name:String = 'slot_null'

func _ready() -> void:
	# 自动查找所有页面和按钮
	auto_find_all_buttons()
	
	# 批量连接所有按钮信号
	batch_connect_all_buttons()

# 自动查找场景中的所有存档按钮并按页面组织
func auto_find_all_buttons() -> void:
	# 清空数组
	save_pages.clear()
	
	# 遍历所有页面
	for page_index in range(total_pages):
		var page_buttons: Array[Node] = []
		
		# 获取页面节点
		var page_node_path = "TabContainer/VBoxContainer" + ("" if page_index == 0 else str(page_index + 1))
		if has_node(page_node_path):
			var page_container = get_node(page_node_path)
			
			# 查找第一个按钮容器中的按钮 (VBoxContainer)
			var container1_path = page_node_path + "/MarginContainer/HBoxContainer/VBoxContainer"
			if has_node(container1_path):
				var container1 = get_node(container1_path)
				for child in container1.get_children():
					if child is Button and child.name.begins_with("Button"):
						page_buttons.append(child)
			
			# 查找第二个按钮容器中的按钮 (VBoxContainer3)
			var container2_path = page_node_path + "/MarginContainer/HBoxContainer/VBoxContainer3"
			if has_node(container2_path):
				var container2 = get_node(container2_path)
				for child in container2.get_children():
					if child is Button and child.name.begins_with("Button"):
						page_buttons.append(child)
		
		# 添加页面按钮数组到总数组
		save_pages.append(page_buttons)
		print("页面 %d 找到 %d 个存档按钮" % [page_index + 1, page_buttons.size()])

# 批量连接所有按钮信号
func batch_connect_all_buttons() -> void:
	# 遍历所有页面
	for page_index in range(save_pages.size()):
		var page_buttons = save_pages[page_index]
		
		# 遍历页面中的所有按钮
		for button_index in range(page_buttons.size()):
			var button = page_buttons[button_index]
			
			# 计算全局按钮索引 (页面索引 * 每页按钮数 + 按钮在页面中的索引)
			var global_button_index = page_index * total_buttons_per_page + button_index
			
			# 生成槽位名称
			var slot_name = "slot_%d" % (global_button_index + 1)
			
			# 断开可能已有的连接（防止重复连接）
			if button.is_connected("pressed", Callable(self, "_on_save_slot_pressed")):
				button.disconnect("pressed", Callable(self, "_on_save_slot_pressed"))
			
			# 连接按钮的pressed信号到处理函数，并传递槽位名称
			button.connect("pressed", Callable(self, "_on_save_slot_pressed").bind(slot_name))
			
			print("已连接页面 %d 的按钮 %s 到槽位 %s" % [page_index + 1, button.name, slot_name])

# 处理存档槽位按钮点击事件
func _on_save_slot_pressed(slot_name: String) -> void:
	print("用户点击了存档槽位: %s" % slot_name)
	current_slot_name= slot_name
	
	


# 保存游戏
func save_game(slot_name: String) -> void:
	# 准备存档信息
	var extra_info := {}
	extra_info["text"] = Dialogic.current_state_info["text"]
	extra_info["date"] = Time.get_datetime_string_from_system(false, true)
	
	# 保存游戏
	Dialogic.Save.save(slot_name, false, Dialogic.Save.ThumbnailMode.STORE_ONLY, extra_info)
	print('保存成功\nText:',extra_info['text'],'\nDate:',extra_info['date'])


func _on_back_pressed() -> void:
	print('返回')
	saving.hide()


func _on_save_pressed() -> void:

	if not current_slot_name == 'slot_null':
		print('保存游戏')
		save_game(current_slot_name)
	else:
		print('未选中存档栏位')


func _on_delete_pressed() -> void:
	if not current_slot_name == 'slot_null':
		print('删除存档')
		Dialogic.Save.delete_slot(current_slot_name)
	else:
		print('未选中存档栏位')


func _on_last_pressed() -> void:
	print('上一页')
	if tab_container.current_tab == 0:
		tab_container.current_tab = 5
	else :
		tab_container.current_tab = tab_container.current_tab - 1
	page.text = str(tab_container.current_tab + 1)
	print('当前页数',tab_container.current_tab + 1)


func _on_next_pressed() -> void:
	print('下一页')
	if tab_container.current_tab == 5:
		tab_container.current_tab = 0
	else :
		tab_container.current_tab = tab_container.current_tab + 1
	page.text = str(tab_container.current_tab + 1)
	print('当前页数',tab_container.current_tab + 1)
