import UnityEngine

class ToonSkeleton(Boss): 
	def Start():
		self.baseAttributes = {
			"HP" :600,
			"MP" : 300,
			"HPSec" : 0,
			"MPSec" : 0,
			"ATK" : 70,
			"DEF" : 3,
			"Spear" : 0.00,
			"Shield" : 0.00,
			"ManaShield" : 0.00,
			"ATKRange" : 1,
			"CritChance" : 0.50,
			"CritDamage" : 1.2,
			"Evasion":0.01,
			"BAT" : 1,
			"MovementSpeed" : 8,
			"Jump" : 2,
		}
		
		// Per Level attrbute gain
		self.perLevelAttributes = {
			"HP" : 300,
			"MP" : 75,
			"HPSec" : 0,
			"MPSec" : 0,
			"ATK" : 20,
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
		self.afterDeath = "Gift"
		super.Start()
	
		
