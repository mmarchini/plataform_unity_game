﻿import UnityEngine

class WarRobot(Enemy): 
	def Start():
		self.baseAttributes["ATKRange"] = 1
		super.Start()