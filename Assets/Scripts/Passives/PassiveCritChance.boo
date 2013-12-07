import UnityEngine

class PassiveCritChance (Passive): 

	def Awake():
		self.label = "Chance Critico"
		self.description = """
Aumenta a chance de Dano Critico 
ganho por level em: 
$(self.PerLevel) x level da passiva
"""
		self.PerLevel = 0.1
	
		self.affects = "CritChance"
	
		self.required_passives = {}
