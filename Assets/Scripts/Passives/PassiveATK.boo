import UnityEngine

class PassiveATK (Passive): 
	
	def Awake():
		self.label = "Aumenta Ataque"
		self.affects = "ATK"
	
		self.required_passives = {}
	