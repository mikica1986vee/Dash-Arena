extends Node2D

# class member variables go here, for example:
# var a = 2
# var b = "textvar"

const HexHolderNode = preload("hex_holder_node.gd")

var _hex_holder = null

var highlight = false setget _set_debug_highlight
var highlight_edge = []

var highlight_color_override = null

func _ready():
	var p = get_parent()
	
	while !p extends HexHolderNode and p != null:
		p = p.get_parent()
	
	if p != null:
		_hex_holder = weakref(p)
	
	pass
	
func _set_debug_highlight(val):
	highlight = val
	update()

func _draw():
	var holder = _hex_holder.get_ref()
	
	if holder != null:
		if holder.debug_draw_hex_edges:
			_draw_hex_edges(holder)
		
		if holder.debug_draw_hex_center:
			_draw_hex_center(holder)
			
	pass
	
func _draw_hex_edges(holder):
	var points = holder.get_hex_point_offsets()
	
	for index in range(points.size() - 1):
		draw_line(points[index], points[index + 1], holder.debug_hex_edge_color, holder.debug_hex_edge_width)
		
	draw_line(points[points.size() - 1], points[0], holder.debug_hex_edge_color, holder.debug_hex_edge_width)
	
	if highlight:
		var col = highlight_color_override
		
		if col == null:
			col = holder.debug_hex_highlight_color
		
		draw_colored_polygon(points, col)
		
		if highlight_edge != null and highlight_edge.size() == 2:
			var edge_color = col
			draw_line(highlight_edge[0], highlight_edge[1], edge_color, holder.debug_hex_edge_width * 8)
	
	pass
	
func _draw_hex_center(holder):
	if highlight:
		return
	draw_circle(Vector2(0, 0), holder.debug_hex_center_radius, holder.debug_hex_edge_color)
	pass