extends Node

var mods_info = []
var mod_nodes = {}

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

func get_file_as_json(path):
	var file = File.new()
	
	file.open(path, File.READ)
	var json = parse_json(file.get_as_text())
	file.close()
	
	return json

func load_mods():
	for mod_dir in list_dir("mods/"):
		var path = "mods/" + mod_dir + "/"
		
		for file in list_dir(path):
			
			if file == "package.json":
				var info = get_file_as_json(path + "package.json")
				mods_info.append(info)
				
				var mod_node = load(path + "/" + info.main).new()
				add_child( mod_node )
				mod_nodes[info.name] = mod_node
	
	emit_signal("mods_loaded")
