extends Node

var alphabet = ['a','b','c','d','e','f','g','h','i','j','k','l']
var rng = RandomNumberGenerator.new()

class Core:
	var consumption = 0
	var rank = null
	var limit = {
		"length": null,
		"stratum": null
	}
	var aspects = []
	
	func set_rank(_rank):
		rank = _rank
		var aspects_size = 0
		
		match _rank:
			1:
				aspects_size = 3
		
		for _i in aspects_size:
			Global.rng.randomize()
			var index = Global.rng.randi_range(0, Global.alphabet.size()-1)
			aspects.append(Global.alphabet[index])

class Augmentor:
	var consumption = 0
	var rank = null
	var battlefield_size = 2
	var aspects = []
	var effect = {
		"cols": [],
		"rows": []
	}
	
	func set_rank(_rank):
		rank = _rank
		var aspects_size = 0
		
		match _rank:
			1:
				aspects_size = 1
		
		for _i in aspects_size:
			Global.rng.randomize()
			var index = Global.rng.randi_range(0, Global.alphabet.size()-1)
			aspects.append(Global.alphabet[index])
	
class Somite:
	var rank = null
	var burthen = {}
	var type = null
	
	func set_burthen(_type, _rank):
		rank = _rank
		type = _type
		
		match _type:
			"Core":
				burthen = Global.Core.new()
			"Augmentor":
				burthen = Global.Augmentor.new()
		burthen.set_rank(rank)
	
class Scheme:
	var rank = null
	var somites_count = null
	var total_aspects = []
	var somites = []
	var spots = []
	var free_spots = []
	var inbuilt_aspects = []
	
	func set_rank(_rank):
		rank = _rank
		somites_count = rank * 2
		add_spot("Core")
		add_spot("Augmentor")
		
		for _i in somites_count:
			Global.rng.randomize()
			var index = Global.rng.randi_range(0, Global.alphabet.size()-1)
			inbuilt_aspects.append(Global.alphabet[index])
	
	func add_spot(_type):
		spots.append(_type)
		free_spots.append(_type)
	
	func add_somite(_somite):
		#var somite = Global.Somite.new()
		#somite.set_burthen(_type)
		var f_index = free_spots.find(_somite.type)
		if f_index != -1:
			free_spots.remove (f_index)
			somites.append(_somite)

class Synergy:
	var alphabet = Global.alphabet
	var n = alphabet.size()
	var type = {
		"name": null,
		"index": null,
		"pool": []
	}
	
	func set_type(index):
		type["index"] = index
		
		var offset = 0
		var shift = index - offset
		
		if index < n:
			type["name"] = "only_" + alphabet[index]
			type["pool"].append(alphabet[index])
			
		offset += n
		shift = index - offset
		
		if shift < 0:
			return
		
		if shift < n/2:
			var _i = shift * 2
			type["name"] = "only_" + alphabet[_i] + "_" + alphabet[_i + 1]
			type["pool"].append(alphabet[_i])
			type["pool"].append(alphabet[_i + 1])
		else: 
			offset += n/2
			shift = index - offset
			
			if shift < 3:
				var _i
				var _j
				
				match shift:
					0:
						_i = 4
						_j = 9
					1:
						_i = 5
						_j = 11
					2:
						_i = 6
						_j = 10
				
				type["name"] = "only_" + alphabet[_i] + "_" + alphabet[_j]
				type["pool"].append(alphabet[_i])
				type["pool"].append(alphabet[_j])
			else:
				offset += 3
				shift = index - offset
				
				if shift < n/3:
					var _i = shift * 3
					type["name"] = "only_" + alphabet[_i] + "_" + alphabet[_i + 1] + "_" + alphabet[_i + 2] 
					type["pool"].append(alphabet[_i])
					type["pool"].append(alphabet[_i + 1])
					type["pool"].append(alphabet[_i + 2])
				else:
					offset += n/3
					shift = index - offset
					
					if shift < 2:
						var _i
						var _j
						var _k
						
						match shift:
							0:
								_i = 0
								_j = 3
								_k = 8
							1:
								_i = 3
								_j = 7
								_k = 11
						
						type["name"] = "only_" + alphabet[_i] + "_" + alphabet[_j] + "_" + alphabet[_k]
						type["pool"].append(alphabet[_i])
						type["pool"].append(alphabet[_j])
						type["pool"].append(alphabet[_k])
					else:
						offset += 2
						shift = index - offset
						
						if shift < n/4:
							var _i = shift * 4
							type["name"] = "only_" + alphabet[_i] + "_" + alphabet[_i + 1] + "_" + alphabet[_i + 2] + "_" + alphabet[_i + 3] 
							type["pool"].append(alphabet[_i])
							type["pool"].append(alphabet[_i + 1])
							type["pool"].append(alphabet[_i + 2])
							type["pool"].append(alphabet[_i + 3])
						else:
							offset += n/4
							shift = index - offset
							
							if shift < 1:
								var _i = 2
								var _j = 5
								var _k = 8
								var _l = 11
								
								type["name"] = "only_" + alphabet[_i] + "_" + alphabet[_j] + "_" + alphabet[_k] + "_" + alphabet[_l]
								type["pool"].append(alphabet[_i])
								type["pool"].append(alphabet[_j])
								type["pool"].append(alphabet[_k])
								type["pool"].append(alphabet[_l])
							else:
								offset += 1
								shift = index - offset
								
								if shift < n/6:
									var _i = shift * 6
									type["name"] = "only_" + alphabet[_i] + "_" + alphabet[_i + 1] + "_" + alphabet[_i + 2] + "_" + alphabet[_i + 3] + "_" + alphabet[_i + 4] + "_" + alphabet[_i + 5]  
									type["pool"].append(alphabet[_i])
									type["pool"].append(alphabet[_i + 1])
									type["pool"].append(alphabet[_i + 2])
									type["pool"].append(alphabet[_i + 3])
									type["pool"].append(alphabet[_i + 4])
									type["pool"].append(alphabet[_i + 5])
								
								else:
									offset += n/6
									shift = index - offset
									
									if shift < 3:
										var _i
										var _j
										var _k
										var _l
										var _m
										var _n
										
										match shift:
											0:
												_i = 1
												_j = 3
												_k = 5
												_l = 7
												_m = 9
												_n = 11
											1:
												_i = 0
												_j = 2
												_k = 4
												_l = 6
												_m = 8
												_n = 10
											2:
												_i = 0
												_j = 1
												_k = 2
												_l = 4
												_m = 6
												_n = 10
										
										type["name"] = "only_" + alphabet[_i] + "_" + alphabet[_j] + "_" + alphabet[_k] + "_" + alphabet[_l] + "_" + alphabet[_m] + "_" + alphabet[_n]
										type["pool"].append(alphabet[_i])
										type["pool"].append(alphabet[_j])
										type["pool"].append(alphabet[_k])
										type["pool"].append(alphabet[_l])
										type["pool"].append(alphabet[_m])
										type["pool"].append(alphabet[_n])
									else:
										offset += 3
										shift = index - offset
										
										if shift < 1:
											type["name"] = "def"
											type["pool"].append_array(alphabet)
										else:
											return

class Drone:
	var name = null
	var scheme = Global.Scheme.new()
	
	func _init():
		scheme.set_rank(1)
		
	func combine():
		for aspect in scheme.inbuilt_aspects:
			scheme.total_aspects.append(aspect)
		for somite in scheme.somites:
			for aspect in somite.burthen.aspects:
				scheme.total_aspects.append(aspect)
	
		print(scheme.total_aspects)
