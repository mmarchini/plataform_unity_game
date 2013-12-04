import UnityEngine

class DarkSkeleton(Enemy): 
	def Start():
		self.baseAttributes["ATKRange"] = 1
		super.Start()
