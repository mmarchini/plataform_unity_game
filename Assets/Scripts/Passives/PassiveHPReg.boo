#import UnityEngine

class PassiveHPReg (Passive): 

	def Awake():
		self.label = "Aumenta HPReg"
		self.description = """
Aumenta o HPReg ganho por level em: 
$(self.PerLevel) x level da passiva
"""
		self.PerLevel = 0.1
		self.MaxLevel = 3
		self.affects = "HPReg"
	
		self.required_passives = {}
