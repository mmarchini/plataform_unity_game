import UnityEngine

class PassiveCritDamage (Passive): 

	def Awake():
		self.label = "Aumenta Dano Critico"
		self.description = """
Aumenta o Dano Critico 
ganho por level em: 
$(self.PerLevel) x level da passiva
"""
		self.PerLevel = 0.1
	
		self.affects = "CritDamage"
	
		self.required_passives = {}
