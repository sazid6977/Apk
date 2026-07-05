@tool
extends EditorPlugin

var export_plugin: UnityAdsExportPlugin

func _enter_tree():
	export_plugin = UnityAdsExportPlugin.new()
	add_export_plugin(export_plugin)

func _exit_tree():
	remove_export_plugin(export_plugin)
	export_plugin = null


class UnityAdsExportPlugin extends EditorExportPlugin:

	func _get_name() -> String:
		return "UnityAdsPlugin"

	func _supports_platform(platform: EditorExportPlatform) -> bool:
		return platform is EditorExportPlatformAndroid

	func _get_android_libraries(platform: EditorExportPlatform, debug: bool) -> PackedStringArray:
		return PackedStringArray(["res://addons/UnityAds/UnityAdsPlugin.aar"])

	func _get_android_manifest_application_element_contents(platform: EditorExportPlatform, debug: bool) -> String:
		return "<meta-data android:name=\"org.godotengine.plugin.v2.UnityAdsPlugin\" android:value=\"com.example.unityadsplugin.UnityAdsPlugin\" />"
