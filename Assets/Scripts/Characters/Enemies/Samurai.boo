import UnityEngine

class Samurai(Enemy): 
	def Start():
		self.baseAttributes = {
			"HP" : 500,
			"MP" : 200,
			"HPSec" : 0,
			"MPSec" : 0,
			"ATK" : 60,
			"DEF" : 7,
			"Spear" : 0.03,
			"Shield" : 0.03,
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
			"HP" : 100,
			"MP" : 50,
			"HPSec" : 0,
			"MPSec" : 0,
			"ATK" : 13,
			"DEF" : 3,
			"Spear" : 0.005,
			"Shield" : 0.008,
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
