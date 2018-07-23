extends "base_test.gd"

# class member variables go here, for example:
# var a = 2
# var b = "textvar"

func _ready():
	# Called every time the node is added to the scene.
	# Initialization here
	pass
	
func _wait_for():
	return 0.0

func _setup():
	var hex_holder_node = get_owner().get_node("hex_holder_test/HexHolder")
	hex_holder_node.generate_hexes()
	
	var arrow_holder = get_node('DirectionArrowHolder')
	arrow_holder.hex_holder_node_path = "../../hex_holder_test/HexHolder"
	
	assert_print(arrow_holder.hex_holder_node == hex_holder_node, 'Hex holder path not set properly')
	
	pass
	
func _run():
	pass
	
func _teardown():
	pass
	