
static func get_child_nodes_of_type(parent, type):
	return _get_child_nodes_of_type(parent, type, [])
	
static func _get_child_nodes_of_type(parent, type, array):
	if parent extends type:
		array.append(parent)
		
	for c in parent.get_children():
		_get_child_nodes_of_type(c, type, array)
	
	return array
