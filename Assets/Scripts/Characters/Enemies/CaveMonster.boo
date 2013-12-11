import UnityEngine

class CaveMonster(Enemy): 
	def Start():
		self.baseAttributes["ATKRange"] = 1.5
		super.Start()
