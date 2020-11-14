extends Node

var testcore

func _ready():
	ModManager.connect("mods_loaded", self, "on_mods_loaded")

func on_mods_loaded():
	testcore = ModManager.mod_nodes.testcore
	
	print( testcore.test )
	
	add_child( load("res://mods/Test mod/second.gd").new() )
