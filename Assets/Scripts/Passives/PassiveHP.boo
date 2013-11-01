import UnityEngine

class PassiveHP (Passive): 

	def Awake():
		self.label = "Aumenta HP"
		self.affects = "HP"
	
		self.required_passives = {}
