@tool
#thumb("Time")
extends Behavior

var _start: int = 0

var elapsed: float:
	get: return (Time.get_ticks_msec() - _start) / 1000.0 if _start > 0 else 0

func start():
	_start = Time.get_ticks_msec()

func stop():
	_start = 0
