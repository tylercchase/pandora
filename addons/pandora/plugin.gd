@tool
extends EditorPlugin

const PandoraEditor := preload("res://addons/pandora/ui/editor/pandora_editor.tscn")
const PandoraIcon := preload("res://addons/pandora/icons/pandora-icon.svg")
const PandoraEntityInspector = preload("res://addons/pandora/ui/editor/inspector/entity_instance_inspector.gd")

var editor_view
var entity_inspector

func _init() -> void:
	self.name = 'PandoraPlugin'


func _enter_tree() -> void:
	add_autoload_singleton("Pandora", "res://addons/pandora/api.gd")
	
	editor_view = PandoraEditor.instantiate()
	editor_view.hide()
	get_editor_interface().get_editor_main_screen().add_child(editor_view)

	entity_inspector = PandoraEntityInspector.new()
	add_inspector_plugin(entity_inspector)
	
	_make_visible(false)
	
	
func _apply_changes() -> void:
	if is_instance_valid(editor_view):
		editor_view.apply_changes()


func _exit_tree() -> void:
	if is_instance_valid(editor_view):
		remove_control_from_bottom_panel(editor_view)
		editor_view.queue_free()
		remove_inspector_plugin(entity_inspector)
		
	remove_autoload_singleton("Pandora")


func _make_visible(visible:bool) -> void:
	if is_instance_valid(editor_view):
		editor_view.visible = visible


func _has_main_screen() -> bool:
	return true


func _get_plugin_name() -> String:
	return "Pandora"
	

func _get_plugin_icon() -> Texture2D:
	return PandoraIcon
