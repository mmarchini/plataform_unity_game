import UnityEngine

def skills_dict():
	return {
		["Fire" , "Fire" , "Fire" ] : "Fire Ball",
		["Fire" , "Fire" , "Wind" ] : "Fire Slash",
		["Fire" , "Fire" , "Water"] : "Lava Sword",
		["Water", "Water", "Water"] : "Water Suit",
		["Water", "Water", "Wind" ] : "???",
		["Water", "Water", "Fire" ] : "Hot Steam",
		["Wind" , "Wind" , "Wind" ] : "???",
		["Wind" , "Wind" , "Fire" ] : "Wild Tornado",
		["Wind" , "Wind" , "Water"] : "???",
		["Fire" , "Water", "Wind" ] : "???",
	}

def GetCurrentSkill(player as Player):
	orbs = player.SelOrbs
	cur_skill as List
	elements_list = ["Fire", "Wind", "Water"]			
	if orbs:
		for skill as List in skills_dict().Keys:
			this_skill = true
			for element in elements_list:
				if Count(skill, element) != Count(orbs, element):
					this_skill = false
			if this_skill:
				cur_skill = skill
				break
		return skills_dict()[cur_skill]
	return ""

def Count(list as List, element as object):
	return len(list.Collect({item | return item == element}))

class CurrentSkill (InterfaceElement): 
	
	def Awake():
		super.Awake()
		self.x = 22
		self.y = 12
		self.width = 30
		self.height = 11
		self.FontSize = 5
		self.TextX = 2
		self.TextY= 1.55
		self.texture = Resources.Load("$(self.gui_path)/Label") as Texture	
	
	
	text as string:
		get:
			return GetCurrentSkill(self.player)
