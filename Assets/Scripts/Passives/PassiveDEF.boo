import UnityEngine

class PassiveDEF (Passive): 

	def Awake():
		self.label = "Aumenta Defesa"
		self.affects = "DEF"
	
		self.required_passives = {}

