extends Node2D

# class member variables go here, for example:
# var a = 2
# var b = "textvar"

export(int, 'S', 'SW', 'NW', 'N', 'NE', 'SE') var from_arrow_direction = 0 setget _set_from_arrow_direction
export(int, 'S', 'SW', 'NW', 'N', 'NE', 'SE') var to_arrow_direction = 0 setget _set_to_arrow_direction

export(int, 'Bidirectional', 'Unidirectional') var direction_arrow_type = 0 setget _set_direction_arrow_type

export(Vector2) var from_hex_coords = Vector2() setget _set_from_hex_coords
export(Vector2) var to_hex_coords = Vector2() setget _set_to_hex_coords

# Must be implemented by every direction arrow type
func initialize(hex_holder, arrow_holder):
	var from = hex_holder.get_hex(from_hex_coords.x, from_hex_coords.y)
	var to = hex_holder.get_hex(to_hex_coords.x, to_hex_coords.y)
	
	if from == null or to == null:
		print('direction_arrow_node: from and to hexes do not exist')
		return
	
	var center = from.get_pos() + (to.get_pos() - from.get_pos()) / 2
	
	set_pos(center)
	
	_set_to_edge_center(get_node("Arrow_1"), from, hex_holder.get_edge_offset(_proper_edge_for_arrow(from_arrow_direction)))
	_set_to_edge_center(get_node("Arrow_2"), to, hex_holder.get_edge_offset(_proper_edge_for_arrow(to_arrow_direction)))
	
	# test
	from.highlight_color_override = Color(0, 0.75, 0, 0.25)
	to.highlight_color_override = Color(0, 0, 0.75, 0.25)
	
	from.highlight_edge = hex_holder.get_edge_offset(_proper_edge_for_arrow(from_arrow_direction))
	to.highlight_edge = hex_holder.get_edge_offset(_proper_edge_for_arrow(to_arrow_direction))
	
	from.highlight = true
	to.highlight = true
	# /test
	
	pass
	
func _proper_edge_for_arrow(direction):
	return (direction + 3) % 6
	
func _set_to_edge_center(arrow, hex, edge):
	var center = edge[0] + (edge[1] - edge[0]) / 2.0
	
	center += hex.get_pos() - get_pos()
	
	arrow.set_pos(center)

func _ready():
	_set_from_arrow_direction(from_arrow_direction)
	_set_to_arrow_direction(to_arrow_direction)
	_set_direction_arrow_type(direction_arrow_type)
	pass

func _set_from_arrow_direction(dir):
	from_arrow_direction = dir
	
	if not is_inside_tree():
		return
	
	get_node("Arrow_1").set_rot(dir * PI/3.0)
	pass
	
func _set_to_arrow_direction(dir):
	to_arrow_direction = dir
	
	if not is_inside_tree():
		return
	
	get_node("Arrow_2").set_rot(dir * PI/3.0)
	pass
	
func _set_direction_arrow_type(type):
	direction_arrow_type = type
	
	if not is_inside_tree():
		return
		
	get_node("Arrow_1").set_hidden(type == 1) # hide if unidirectional
	
func _set_from_hex_coords(vec2):
	from_hex_coords.x = floor(vec2.x)
	from_hex_coords.y = floor(vec2.y)
	
func _set_to_hex_coords(vec2):
	to_hex_coords.x = floor(vec2.x)
	to_hex_coords.y = floor(vec2.y)