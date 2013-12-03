import UnityEngine

class BasicSkeleton(Enemy): 
	def Start():
		self.baseAttributes["ATKRange"] = 1
		super.Start()
