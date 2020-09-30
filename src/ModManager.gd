extends Node

func _ready():
	load_mods()

func load_mods():
	var dir = Directory.new()
	var path = "./mods"
	
	var mods = []
	
	if dir.open(path) == OK:
		dir.list_dir_begin(true)
		var mod = dir.get_next()
		while mod != "":
			if mod.ends_with(".gd"):
				mods.append( load(path + "/" + mod) )
			
			mod = dir.get_next()
	
	for mod in mods:
		add_child( mod.new() )
