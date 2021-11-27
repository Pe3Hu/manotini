extends Node2D


#var core = Global.Core.new()

var all_synergys
var trade_somites = {}

func init_synergys():
	all_synergys = {}
	
	for n in 37:
		var synergy = Global.Synergy.new()
		synergy.set_type(n)
		
		if all_synergys.keys().find(synergy.type["pool"].size()) == -1:
			all_synergys[synergy.type["pool"].size()] = []
		
		all_synergys[synergy.type["pool"].size()].append(n)
	
	#print(all_synergys)

func init_somites():
	var count = 2
	var rank = 1
	trade_somites = {
		"Core": [],
		"Augmentor": []
	}
	
	for type in trade_somites.keys():
		for _i in count:
			var somite = Global.Somite.new()
			somite.set_burthen(type, rank)
			trade_somites[type].append(somite)

func init_drone():
	var drone = Global.Drone.new()
	var _i = drone.scheme.free_spots.size() - 1
	
	while _i >= 0:
		var type = drone.scheme.free_spots[_i]
		var somites = trade_somites[type]
		Global.rng.randomize()
		var index = Global.rng.randi_range(0, somites.size()-1)
		drone.scheme.add_somite(somites[index])
		trade_somites[type].remove(index)
		drone.scheme.free_spots.remove(_i)
		_i -= 1
	
	drone.combine()

func _ready():
	init_synergys()
	init_somites()
	init_drone()
