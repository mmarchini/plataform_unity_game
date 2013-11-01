import UnityEngine

class PassiveCritDamage (Passive): 

	def Awake():
		self.label = "Aumenta Dano Critico"
	
		self.affects = "CritDamage"
	
		self.required_passives = {}
