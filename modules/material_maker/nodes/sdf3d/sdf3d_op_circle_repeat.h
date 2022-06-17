#ifndef MM_SDF3D_OP_CIRCLE_REPEAT_H
#define MM_SDF3D_OP_CIRCLE_REPEAT_H

#include "../mm_node.h"
#include "../mm_node_universal_property.h"

class MMSdf3dOpCircleRepeat : public MMNode {
	GDCLASS(MMSdf3dOpCircleRepeat, MMNode);

public:
	Ref<MMNodeUniversalProperty> get_input();
	void set_input(const Ref<MMNodeUniversalProperty> &val);

	Ref<MMNodeUniversalProperty> get_output();
	void set_output(const Ref<MMNodeUniversalProperty> &val);

	int get_count() const;
	void set_count(const int val);

	void _init_properties();
	void _register_methods(MMGraphNode *mm_graph_node);
	Vector2 _get_property_value_sdf3d(const Vector3 &uv3);

	void on_input_changed();

	MMSdf3dOpCircleRepeat();
	~MMSdf3dOpCircleRepeat();

protected:
	static void _bind_methods();

	Ref<MMNodeUniversalProperty> input;
	Ref<MMNodeUniversalProperty> output;
	int count;
};

#endif
