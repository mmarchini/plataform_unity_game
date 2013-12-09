import UnityEngine

class PassiveMP (Passive): 

	def Awake():
		self.label = "Aumenta MP"
		self.description = """
Aumenta o MPReg ganho por level em: 
$(self.PerLevel) x level da passiva
"""
		self.PerLevel = 2
		self.affects = "MP"
	
		self.required_passives = {}

