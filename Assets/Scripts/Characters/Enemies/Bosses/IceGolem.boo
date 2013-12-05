import UnityEngine

class IceGolem(Enemy): 
	def Start():
		self.baseAttributes["ATKRange"] = 1
		super.Start()
