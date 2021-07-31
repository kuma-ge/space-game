extends MarginContainer

onready var languages := $TabContainer/SETTINGS/CenterContainer/VBoxContainer/Languages


func _ready():
	_init_languages_select()


func _init_languages_select():
	var locale = TranslationServer.get_locale()
	languages.set_value("LANG_" + locale.to_upper())


func _on_Languages_item_selected(index):
	var lang = languages.get_item_text(index)
	var locale = lang.substr("LANG_".length())
	TranslationServer.set_locale(locale.to_lower())
