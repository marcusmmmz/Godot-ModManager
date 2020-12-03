extends Node

func _ready():
	ModManager.connect("mods_loaded", self, "on_mods_loaded")

func on_mods_loaded():
	var testcore = ModManager.get_node("testcore")
	print( testcore.test )
	
	add_child( load("res://mods/Test mod/second.gd").new() )
