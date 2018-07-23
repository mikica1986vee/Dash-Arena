extends Node

# class member variables go here, for example:
# var a = 2
# var b = "textvar"

export var run_test = true

var wait_for = 0.0

func _ready():
	if not run_test:
		return
	
	wait_for = _wait_for()
	
	if wait_for > 0.0:
		set_process(true)
		return
	
	_setup()
	_run()
	_teardown()
	pass
	
func _process(delta):
	wait_for -= delta
	
	if wait_for < 0.0:
		_setup()
		_run()
		_teardown()
		set_process(false)
		
func _wait_for():
	return 0.0

func _setup():
	print('you must override _setup()')
	assert(false)
	
func _run():
	print('you must override _run()')
	assert(false)
	
func _teardown():
	print('you must override _teardown()')
	assert(false)

func assert_print(condition, text):
	if condition == false:
		print(text)
	
	assert(condition)