//
//  Generated file. Do not edit.
//

// clang-format off

#include "generated_plugin_registrant.h"

#include <resizable_draggable_widget/resize_drag_widget_plugin.h>

void fl_register_plugins(FlPluginRegistry* registry) {
  g_autoptr(FlPluginRegistrar) resizable_draggable_widget_registrar =
      fl_plugin_registry_get_registrar_for_plugin(registry, "ResizeDragWidgetPlugin");
  resize_drag_widget_plugin_register_with_registrar(resizable_draggable_widget_registrar);
}
