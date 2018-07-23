extends "base_test.gd"

# class member variables go here, for example:
# var a = 2
# var b = "textvar"
const HexHolderNode = preload("res://scripts/nodes/board/hex_holder_node.gd")

var hex_holder_node = HexHolderNode.new()

func _setup():
	hex_holder_node.hex_width = 7
	hex_holder_node.hex_height = 6
	hex_holder_node.hex_pixel_scale = 8
	hex_holder_node.hex_row_count = 7
	hex_holder_node.hex_column_count = 10
	
	hex_holder_node.center_hexes = false
	
	hex_holder_node.hex_scene = load("res://scenes/board/hex.tscn")

	hex_holder_node.debug_draw_hex_edges = true
	hex_holder_node.debug_draw_hex_center = true
	hex_holder_node.debug_hex_edge_color = Color(1, 1, 0, 0.5)
	hex_holder_node.debug_hex_edge_width = 2
	hex_holder_node.debug_hex_center_radius = 2
	hex_holder_node.debug_hex_highlight_color = Color(1, 0.5, 0, 0.25)
	
	#get_node("HexHolder").generate_hexes()
	
	hex_holder_node.generate_hexes()
	
	add_child(hex_holder_node)
	
func _run():
	assert_print(hex_holder_node.hex_scene != null, 'hex scene is null!')
	_get_hex_test(0, 0)
	_get_hex_test(0, 1)
	_get_hex_test(0, 2)
	_get_hex_test(1, 0)
	_get_hex_test(1, 1)
	_get_hex_test(1, 2)
	_get_hex_test(2, 2)
	
	assert_print(hex_holder_node.get_hex_width_px() == hex_holder_node.hex_width * hex_holder_node.hex_pixel_scale, 'get_hex_width_px wrong result')
	assert_print(hex_holder_node.get_hex_height_px() == hex_holder_node.hex_height * hex_holder_node.hex_pixel_scale, 'get_hex_height_px wrong result')
	
	assert_print(hex_holder_node.get_edge_offset(0)[0] == hex_holder_node.get_edge_offset(5)[1], 'get_edge not working')
	
func _teardown():
	#hex_holder_node.free()
	pass

func _get_hex_test(row, col):
	var hex = hex_holder_node.get_hex(row, col)
	assert_print(hex_holder_node.get_hex_from_pos(hex.get_pos()) == hex, 'get_hex(%d, %d) != get_hex_from_pos(hex.get_pos())' % [row, col])
	pass