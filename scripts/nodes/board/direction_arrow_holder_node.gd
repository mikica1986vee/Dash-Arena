extends Node2D

# class member variables go here, for example:
# var a = 2
# var b = "textvar"
const HexHolderNode = preload('hex_holder_node.gd')
const DirectionArrowNode = preload('direction_arrow_node.gd')
const NodeUtils = preload('res://scripts/utils/node_utils.gd')

export(NodePath) var hex_holder_node_path setget _set_hex_holder_node_path

export var distance_from_hex_edge = 1

var hex_holder_node = null

var direction_arrows = []

func _ready():
	# Called every time the node is added to the scene.
	# Initialization here
	if hex_holder_node_path != null:
		hex_holder_node = get_node(hex_holder_node_path)
	
	_update_direction_arrow_positions()
	pass
	
func _update_direction_arrow_positions():
	if hex_holder_node == null:
		return
	
	direction_arrows = NodeUtils.get_child_nodes_of_type(self, DirectionArrowNode)
	
	for d in direction_arrows:
		d.initialize(hex_holder_node, self)
		
	
	pass

func _set_hex_holder_node_path(path):
	hex_holder_node_path = path
	
	if is_inside_tree():
		var new_node = get_node(path)
		
		if hex_holder_node != new_node: 
			hex_holder_node = new_node
			
			_update_direction_arrow_positions()
			