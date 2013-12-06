import UnityEngine

class GiantSpider(Boss): 
	def Start():
		self.baseAttributes["ATKRange"] = 1
		super.Start()
