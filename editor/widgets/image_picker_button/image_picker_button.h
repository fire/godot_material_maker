#ifndef IMAGE_PICKER_BUTTON_H
#define IMAGE_PICKER_BUTTON_H

#include "core/variant/array.h"
#include "core/string/ustring.h"

#include "scene/gui/texture_button.h"

class MatMakerFileDialog;

class ImagePickerButton : public TextureButton {
	GDCLASS(ImagePickerButton, TextureButton);

public:
	String get_image_path();
	void set_image_path(const String &path);

	void do_set_image_path(const String &path);

	void _on_ImagePicker_pressed();
	void on_drop_image_file(const String &file_name);
	void on_file_selected(const Array &arr);

	ImagePickerButton();
	~ImagePickerButton();

protected:
	void _notification(int p_what);
	static void _bind_methods();

	String image_path;

	MatMakerFileDialog *dialog;
};

#endif
