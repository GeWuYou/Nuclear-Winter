extends Node2D

func _ready() -> void:
	# 检查Dialogic是否有活跃的时间轴
	if Dialogic.current_timeline != null:
		# 如果已经有时间轴在运行，说明是从加载状态恢复的
		Dialogic.start(Dialogic.current_timeline, Dialogic.current_event_idx)
		return
	
	# 没有活跃的时间轴，这是新游戏开始
	Dialogic.start("序章1")
