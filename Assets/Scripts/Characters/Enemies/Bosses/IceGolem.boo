import UnityEngine

class IceGolem(Boss): 
	def Start():
		self.baseAttributes["ATKRange"] = 1
		super.Start()
