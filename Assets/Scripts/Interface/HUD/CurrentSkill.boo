import UnityEngine

def GetCurrentSkill(player as Player) as Skill:
	orbs = player.SelOrbs
	cur_skill as List
	elements_list = ["Fire", "Wind", "Water"]			
	if orbs:
		for skill as List in player.skills.Keys:
			this_skill = true
			for element in elements_list:
				if Count(skill, element) != Count(orbs, element):
					this_skill = false
			if this_skill:
				cur_skill = skill
				break
		return player.skills[cur_skill]
	return Skill()

def Count(list as List, element as object):
	return len(list.Collect({item | return item == element}))

class CurrentSkill (InterfaceElement): 
	
	def Awake():
		super.Awake()
		self.x = 22
		self.y = 6
		self.width = 22
		self.height = 6
		self.FontSize = 4
		self.TextX = 2
		self.TextY= 1
		self.texture = Resources.Load("$(self.gui_path)/Label") as Texture	
	
	
	text as string:
		get:
			return GetCurrentSkill(self.player).label
