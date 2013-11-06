import UnityEngine

class SkillLavaSword (Skill): 

	def Awake():
		self.type = SkillType.Buff
		self.orbs = []
		self.label = "Lava Sword"
		self.description = "Transforma sua espada em uma espada de lava, aumentando o ataque e o ATKRange. Consome MP/Seg"
		
	virtual def Execute():
		pass
