import UnityEngine

class PassiveMPReg (Passive): 

	def Awake():
		self.label = "Aumenta MPReg"
		self.description = """
Aumenta o MPReg ganho por level em: 
$(self.PerLevel) x level da passiva
"""
		self.PerLevel = 0.2
		self.MaxLevel = 3
		self.affects = "MP"
	
		self.required_passives = {}

