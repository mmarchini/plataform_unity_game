import UnityEngine

class WarRobot(Boss): 
	def Start():
		self.baseAttributes["ATKRange"] = 1
		super.Start()
