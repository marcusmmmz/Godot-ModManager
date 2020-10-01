extends Node

var mods = []

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
	
	return files

func load_mods():
	var path = "./mods/"
	for mod_dir in list_dir("./mods"):
		
		path += mod_dir + "/"
		for dir_file in list_dir(path):
			
			match dir_file:
				"index.gd":
					add_child( load(path + "/index.gd").new() )
				
				"info.json":
					var file = File.new()
					file.open(path + "info.json", File.READ)
					mods.append(parse_json(file.get_as_text()))
					file.close()
