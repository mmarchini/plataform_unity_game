#import UnityEngine

class PassiveHP (Passive): 

	def Awake():
		self.label = "Aumenta HP"
		self.description = """
Aumenta o HP ganho por level em: 
$(self.PerLevel) x level da passiva
"""
		self.PerLevel = 18
		self.affects = "HP"
	
		self.required_passives = {}
