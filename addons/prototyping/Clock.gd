@tool
extends TextureRect

signal elapsed()

@export var one_shot: bool:
	get: return _timer.one_shot
	set(value): _timer.one_shot
@export var duration_seconds: float = 1.0:
	get: return _timer.wait_time
	set(value): _timer.wait_time = max(value, 0.0001)
@export var paused: bool:
	get: return _timer.paused
	set(value): _timer.paused = value

var _timer: Timer:
	get:
		if not _timer: _timer = Timer.new()
		return _timer

func _ready():
	texture = Utils.icon_from_theme("Timer", self)
	
	if not Engine.is_editor_hint():
		_timer.autostart = true
		_timer.timeout.connect(func(): elapsed.emit())
		add_child(_timer)
