import UnityEngine

class PassiveMP (Passive): 

	def Awake():
		self.label = "Aumenta MP"
		self.description = """
Aumenta o MP ganho por level em: 
$(self.PerLevel) x level da passiva
"""
		self.affects = "MP"
	
		self.required_passives = {}

