import UnityEngine

class DarkSkeleton(Boss): 
	def Start():
		self.baseAttributes["ATKRange"] = 1
		self.afterDeath="Map5"
		super.Start()
