import UnityEngine

class BasicSkeleton(Enemy): 
	
	
	def Start():
		self.baseAttributes = {
			"HP" : 50,
			"MP" : 200,
			"HPSec" : 0,
			"MPSec" : 0,
			"ATK" : 50,
			"DEF" : 1,
			"Spear" : 0.03,
			"Shield" : 0.02,
			"ManaShield" : 0.00,
			"ATKRange" : 1,
			"CritChance" : 0.10,
			"CritDamage" : 1.5,
			"Evasion":0.01,
			"BAT" : 1,
			"MovementSpeed" : 4,
			"Jump" : 2,
		}
		
		// Per Level attrbute gain
		self.perLevelAttributes = {
			"HP" : 150,
			"MP" : 50,
			"HPSec" : 0,
			"MPSec" : 0,
			"ATK" : 10,
			"DEF" : 0.1,
			"Spear" : 0.005,
			"Shield" : 0.005,
			"ManaShield" : 0,
			"ATKRange" : 0,
			"CritChance" : 0,
			"CritDamage" : 0,
			"Evasion":0,
			"BAT" : 0,
			"MovementSpeed" : 0.5,
			"Jump" : 0,
		}
		super.Start()
