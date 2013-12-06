import UnityEngine

class ToonSkeleton(Boss): 
	def Start():
		self.baseAttributes["ATKRange"] = 1
		super.Start()
