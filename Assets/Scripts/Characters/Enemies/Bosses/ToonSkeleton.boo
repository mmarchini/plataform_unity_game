import UnityEngine

class ToonSkeleton(Enemy): 
	def Start():
		self.baseAttributes["ATKRange"] = 1
		super.Start()
