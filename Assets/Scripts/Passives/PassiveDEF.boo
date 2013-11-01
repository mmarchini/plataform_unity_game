import UnityEngine

class PassiveDEF (Passive): 

	def Awake():
		self.label = "Aumenta Defesa"
		self.description = """
Aumenta a DEF ganho por level em: 
$(self.PerLevel) x level da passiva
"""
		self.PerLevel = 0.3
		self.affects = "DEF"
	
		self.required_passives = {}
