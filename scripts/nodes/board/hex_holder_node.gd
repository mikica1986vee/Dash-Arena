extends Node2D

# class member variables go here, for example:
# var a = 2
# var b = "textvar"

enum Direction {S, SW, NW, N, NE, SE}

export(int) var hex_width = 7
export(int) var hex_height = 6
export(int) var hex_pixel_scale = 32
export(int) var hex_row_count = 8
export(int) var hex_column_count = 7
export(bool) var center_hexes = true

export(PackedScene) var hex_scene = null

export(bool) var debug_draw_hex_edges = false
export(bool) var debug_draw_hex_center = false
export(Color) var debug_hex_edge_color = Color(0, 0, 0, 0.5)
export(float) var debug_hex_edge_width = 1.0
export(float) var debug_hex_center_radius = 2
export(Color) var debug_hex_highlight_color = Color(1, 1, 1, 0.25)

var _index_to_hex_map = {}
var _hex_to_index_map = {}

var point_offsets = []

func _ready():
	# Called every time the node is added to the scene.
	# Initialization here
	pass

func generate_hexes():
	if hex_scene != null:
		for child in get_children():
			remove_child(child)
		
		var height = hex_height * hex_pixel_scale
		var width = hex_width * hex_pixel_scale
		
		# get_pos should return center of hex
		var center_offset_x = width / 2.0
		var center_offset_y = height / 2.0
		
		if center_hexes:
			center_offset_x += _get_center_offset_x()
			center_offset_y += _get_center_offset_y()
			
		# reset everything
		_index_to_hex_map.clear()
		_hex_to_index_map.clear()
		
		for row in range(hex_row_count):
			var offset_y = row % 2 * height / 2.0
			for column in range(hex_column_count):
				var hex = hex_scene.instance()
				var index = Vector2(row, column)
				
				_index_to_hex_map[index] = hex
				_hex_to_index_map[hex] = index
				
				add_child(hex)
				var pos = Vector2(row * width * 3.0 / 4.0 + center_offset_x, column * height + offset_y + center_offset_x)
				hex.set_pos(pos)
				#print(str(Vector2(row, column)) + ': ' + str(pos))
		
		update_hex_point_offsets()
	
	pass
	
func get_hex(row, column):
	var index = Vector2(row, column)
	
	if _index_to_hex_map.has(index):
		return _index_to_hex_map[index]
	return null
	
func get_coords_from_pos(vec2):
	var pos_x = vec2.x
	var pos_y = vec2.y
	
	if center_hexes:
		pos_x += - _get_center_offset_x()
		pos_y += - _get_center_offset_y()
	
	var row = int(pos_x / hex_pixel_scale / hex_width)
	var col = int((pos_y / hex_pixel_scale - (row % 2) * hex_height / 2.0) / hex_height)
	
	return Vector2(row, col)
	
func get_hex_from_pos(vec2):
	var coords = get_coords_from_pos(vec2)
	
	return get_hex(coords.x, coords.y)
	
func get_hex_width_px():
	return hex_width * hex_pixel_scale
	
func get_hex_height_px():
	return hex_height * hex_pixel_scale
	
func update_hex_point_offsets():
	var width = hex_width * hex_pixel_scale
	var height = hex_height * hex_pixel_scale
	var side = width / 2.0
	var x_left_top = (width - side) / 2.0
	var x_right_top = (width - side) / 2.0 + side
	
	var offset_x = -width / 2.0
	var offset_y = -height / 2.0
	
	point_offsets = [
		Vector2(x_left_top + offset_x, height + offset_y),
		Vector2(x_right_top + offset_x, height + offset_y),
		Vector2(width + offset_x, height / 2.0 + offset_y),
		Vector2(x_right_top + offset_x, 0 + offset_y),
		Vector2(x_left_top + offset_x, 0 + offset_y),
		Vector2(0 + offset_x, height / 2.0 + offset_y)
	]
	
func get_hex_point_offsets():
	return point_offsets
	
func get_edge_offset(direction):
	var first = point_offsets[direction]
	var last = point_offsets[(direction + 1) % 6]
	
	return [first, last]

func _get_center_offset_x():
	var width = hex_width * hex_pixel_scale
	return - hex_row_count * width * 3.0 / 4.0 / 2.0
	
func _get_center_offset_y():
	var height = hex_height * hex_pixel_scale
	return - hex_column_count * height / 2.0 + height / 2.0