import UnityEngine

class FightRobot(Enemy): 
	def Start():
		if ConditionalController.IsClauseSatisfied("KillL"):
			self.Level = self.Level + 3 
		self.baseAttributes = {
			"HP" : 500,
			"MP" : 200,
			"HPSec" : 0,
			"MPSec" : 0,
			"ATK" : 50,
			"DEF" : 3,
			"Spear" : 0.04,
			"Shield" : 0.01,
			"ManaShield" : 0.00,
			"ATKRange" : 1,
			"CritChance" : 0.2,
			"CritDamage" : 2,
			"Evasion":0.01,
			"BAT" : 1,
			"MovementSpeed" : 6,
			"Jump" : 2,
		}
		
		// Per Level attrbute gain
		self.perLevelAttributes = {
			"HP" : 90,
			"MP" : 50,
			"HPSec" : 0,
			"MPSec" : 0,
			"ATK" : 15,
			"DEF" : 0.5,
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
	
	