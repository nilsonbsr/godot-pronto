@tool
#thumb("GPUParticles3D")
extends Behavior

var scene = null

signal spawned(instance: Node)

func _ready():
	super._ready()
	
	if not Engine.is_editor_hint():
		scene = get_child(0)
		remove_child(scene)

func _spawn():
	var i = scene.duplicate(DUPLICATE_USE_INSTANTIATION | DUPLICATE_SCRIPTS | DUPLICATE_SIGNALS | DUPLICATE_GROUPS)
	i.position = Vector2.ZERO
	return i

func spawn():
	var instance = _spawn()
	
	var path_corrector = Node2D.new() if instance is Node2D else Node3D.new()
	path_corrector.add_child(instance)
	path_corrector.position = position
	
	get_parent().add_child(path_corrector)
	spawned.emit(instance)
	
	return instance

func spawn_toward(pos: Vector2):
	var instance = _spawn()
	
	var path_corrector = Node2D.new() if instance is Node2D else Node3D.new()
	
	path_corrector.add_child(instance)
	path_corrector.top_level = true
	path_corrector.global_position = global_position
	path_corrector.rotation = global_position.angle_to_point(pos)
	
	get_parent().add_child(path_corrector)
	spawned.emit(instance)
	
	return instance

func lines():
	return super.lines() + ([Lines.DashedLine.new(self, get_child(0), func (f): return "spawns", "spawns")] if get_child_count() > 0 else [])
