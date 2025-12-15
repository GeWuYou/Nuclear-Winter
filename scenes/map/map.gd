extends Node2D

# 地点按钮引用
@onready var location_nodes = {
	"避难所": $"避难所",
	"修道院": $"修道院",
	"郊区": $"郊区",
	"市区": $"市区",
	"乡镇": $"乡镇",
	"森林": $"森林"
}

func _ready() -> void:
	setup_characters_from_config()

func setup_characters_from_config() -> void:
	var config = MapManager.get_map_configuration()
	
	# 遍历所有地点节点并设置角色显示和交互状态
	for location_name in location_nodes.keys():
		var location_node = location_nodes[location_name]
		
		# 根据配置更新按钮文本和交互状态
		if config.has(location_name) and config[location_name].size() > 0:
			# 有配置：显示"地点_角色"文本，启用按钮交互
			var characters_text = ""
			for character in config[location_name]:
				characters_text += "_" + character
			
			location_node.text = location_name + characters_text
			location_node.disabled = false
		else:
			# 无配置：显示原始地点名称，禁用按钮交互
			location_node.text = location_name
			location_node.disabled = true

func _exit_tree() -> void:
	MapManager.clear_configuration()
