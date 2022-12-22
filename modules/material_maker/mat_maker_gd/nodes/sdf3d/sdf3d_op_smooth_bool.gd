tool
extends MMNode

const Commons = preload("res://addons/mat_maker_gd/nodes/common/commons.gd")
var SDF3D = preload("res://addons/mat_maker_gd/nodes/common/sdf3d.gd")

export(Resource) var input1 : Resource
export(Resource) var input2 : Resource
export(Resource) var output : Resource
export(int, "Union,Subtraction,Intersection") var operation : int = 0
export(float) var smoothness : float = 0.15

func _init_properties():
	if !input1:
		input1 = MMNodeUniversalProperty.new()
		input1.default_type = MMNodeUniversalProperty.MMNodeUniversalPropertyDefaultType.DEFAULT_TYPE_VECTOR2
		
	input1.input_slot_type = MMNodeUniversalProperty.SlotTypes.SLOT_TYPE_UNIVERSAL
#	input1.input_slot_type = MMNodeUniversalProperty.SlotTypes.SLOT_TYPE_VECTOR2
	input1.slot_name = ">>>   Input 1        "
	
	if !input1.is_connected("changed", self, "on_input_changed"):
		input1.connect("changed", self, "on_input_changed")
		
	if !input2:
		input2 = MMNodeUniversalProperty.new()
		input2.default_type = MMNodeUniversalProperty.MMNodeUniversalPropertyDefaultType.DEFAULT_TYPE_VECTOR2
		
	input2.input_slot_type = MMNodeUniversalProperty.SlotTypes.SLOT_TYPE_UNIVERSAL
#	input2.input_slot_type = MMNodeUniversalProperty.SlotTypes.SLOT_TYPE_VECTOR2
	input2.slot_name = ">>>   Input 2        "
	
	if !input2.is_connected("changed", self, "on_input_changed"):
		input2.connect("changed", self, "on_input_changed")
	
	if !output:
		output = MMNodeUniversalProperty.new()
		output.default_type = MMNodeUniversalProperty.MMNodeUniversalPropertyDefaultType.DEFAULT_TYPE_VECTOR2
		
	output.output_slot_type = MMNodeUniversalProperty.SlotTypes.SLOT_TYPE_FLOAT
	output.slot_name = ">>>   Output    >>>"
	output.get_value_from_owner = true

	register_input_property(input1)
	register_input_property(input2)
	register_output_property(output)

func _register_methods(mm_graph_node) -> void:
	mm_graph_node.add_slot_label_universal(input1)
	mm_graph_node.add_slot_label_universal(input2)
	mm_graph_node.add_slot_label_universal(output)
	
	mm_graph_node.add_slot_enum("get_operation", "set_operation", "Operation", [ "Union", "Subtraction", "Intersection" ])
	mm_graph_node.add_slot_float("get_smoothness", "set_smoothness", "Smoothness", 0.01)

func get_property_value_sdf3d(uv3 : Vector3) -> Vector2:
	var s1 : Vector2 = input1.get_value_sdf3d(uv3)
	var s2 : Vector2 = input2.get_value_sdf3d(uv3)
	
	if operation == 0:
		return SDF3D.sdf3d_smooth_union(s1, s2, smoothness)
	elif operation == 1:
		return SDF3D.sdf3d_smooth_subtraction(s1, s2, smoothness)
	elif operation == 2:
		return SDF3D.sdf3d_smooth_intersection(s1, s2, smoothness)
	
	return Vector2()

#operation
func get_operation() -> int:
	return operation

func set_operation(val : int) -> void:
	operation = val

	emit_changed()
	output.emit_changed()

#smoothness
func get_smoothness() -> float:
	return smoothness

func set_smoothness(val : float) -> void:
	smoothness = val

	emit_changed()
	output.emit_changed()

func on_input_changed() -> void:
	emit_changed()
	output.emit_changed()
