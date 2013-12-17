import UnityEngine

class GiantSpider(Boss): 
	def Start():
		self.baseAttributes = {
			"HP" :800,
			"MP" : 300,
			"HPSec" : 0,
			"MPSec" : 0,
			"ATK" : 30,
			"DEF" : 3,
			"Spear" : 0.00,
			"Shield" : 0.00,
			"ManaShield" : 0.00,
			"ATKRange" : 1,
			"CritChance" : 0.05,
			"CritDamage" : 1.2,
			"Evasion":0.01,
			"BAT" : 1,
			"MovementSpeed" : 8,
			"Jump" : 2,
		}
		
		// Per Level attrbute gain
		self.perLevelAttributes = {
			"HP" : 600,
			"MP" : 75,
			"HPSec" : 0,
			"MPSec" : 0,
			"ATK" : 7,
			"DEF" : 0.3,
			"Spear" : 0.000,
			"Shield" : 0.000,
			"ManaShield" : 0,
			"ATKRange" : 0,
			"CritChance" : 0,
			"CritDamage" : 0,
			"Evasion":0,
			"BAT" : 0,
			"MovementSpeed" : 0.5,
			"Jump" : 0,
		}
		if ConditionalController.IsClauseSatisfied("KillU"):
			self.Level = self.Level + 3 
		super.Start()
