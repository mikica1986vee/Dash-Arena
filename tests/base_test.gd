extends Node

# class member variables go here, for example:
# var a = 2
# var b = "textvar"

export var run_test = true

func _ready():
	_setup()
	_run()
	_teardown()
	pass

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