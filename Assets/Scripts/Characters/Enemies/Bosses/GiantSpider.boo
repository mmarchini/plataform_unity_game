import UnityEngine

class GiantSpider(Enemy): 
	def Start():
		self.baseAttributes["ATKRange"] = 1
		super.Start()
