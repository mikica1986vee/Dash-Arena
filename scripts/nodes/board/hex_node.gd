extends Node2D

# class member variables go here, for example:
# var a = 2
# var b = "textvar"

const HexHolderNode = preload("hex_holder_node.gd")

var _hex_holder = null

func _ready():
	var p = get_parent()
	
	while !p extends HexHolderNode and p != null:
		p = p.get_parent()
	
	if p != null:
		_hex_holder = weakref(p)
	
	pass

func _draw():
	var holder = _hex_holder.get_ref()
	
	if holder != null:
		if holder.debug_draw_hex_edges:
			_draw_hex_edges(holder)
		
		if holder.debug_draw_hex_center:
			_draw_hex_center(holder)
			
	pass
	
func _draw_hex_edges(holder):
	var width = holder.hex_width * holder.hex_pixel_scale
	var height = holder.hex_height * holder.hex_pixel_scale
	var side = width / 2.0
	var x_left_top = (width - side) / 2.0
	var x_right_top = (width - side) / 2.0 + side
	
	var offset_x = -width / 2.0
	var offset_y = -height / 2.0
	
	var points = [
		Vector2(x_left_top + offset_x, 0 + offset_y),
		Vector2(x_right_top + offset_x, 0 + offset_y),
		Vector2(width + offset_x, height / 2.0 + offset_y),
		Vector2(x_right_top + offset_x, height + offset_y),
		Vector2(x_left_top + offset_x, height + offset_y),
		Vector2(0 + offset_x, height / 2.0 + offset_y)
	]
	
	for index in range(points.size() - 1):
		draw_line(points[index], points[index + 1], holder.debug_hex_edge_color, holder.debug_hex_edge_width)
		
	draw_line(points[points.size() - 1], points[0], holder.debug_hex_edge_color, holder.debug_hex_edge_width)
	
	pass
	
func _draw_hex_center(holder):
	draw_circle(Vector2(0, 0), holder.debug_hex_center_radius, holder.debug_hex_edge_color)
	pass