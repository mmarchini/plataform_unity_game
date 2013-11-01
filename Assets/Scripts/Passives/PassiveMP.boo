import UnityEngine

class PassiveMP (Passive): 

	def Awake():
		self.label = "Aumenta MP"
		self.affects = "MP"
	
		self.required_passives = {}

