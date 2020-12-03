extends Node

var mods_info := {}

signal mods_loaded

func _ready():
	load_mods()

func list_dir(path):
	var dir = Directory.new()
	
	var files = []
	
	if dir.open(path) == OK:
		dir.list_dir_begin(true)
		var file = dir.get_next()
		
		while file != "":
			files.append( file )
			file = dir.get_next()
		
		dir.list_dir_end()
	
	return files

func load_mods():
	for mod_dir in list_dir("mods/"):
		var path = "mods/" + mod_dir + "/"
		
		for file in list_dir(path):
				
			if file == "package.tres":
				var info = load("res://mods/" + mod_dir + "/package.tres")
				mods_info[info.name] = info
				
				var mod_node = load(path + "/" + info.main).new()
				mod_node.name = info.name
				add_child( mod_node )
	
	emit_signal("mods_loaded")
