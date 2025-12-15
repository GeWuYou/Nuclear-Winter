extends Node

# 存储当前地图显示配置
var current_map_config = {}

func set_map_configuration(...config_strings) -> void:
	# 清空现有配置
	current_map_config.clear()
	
	# 解析每个字符串参数
	for config_str in config_strings:
		if "+" in config_str:
			var parts = config_str.split("+")
			if parts.size() == 2:
				var location = parts[0].strip_edges()
				var character = parts[1].strip_edges()
				if not current_map_config.has(location):
					current_map_config[location] = []
				current_map_config[location].append(character)
	
	Dialogic.end_timeline()
	# 跳转到地图场景
	get_tree().change_scene_to_file("res://scenes/map/map.tscn")

func get_map_configuration() -> Dictionary:
	return current_map_config

func clear_configuration() -> void:
	current_map_config.clear()
