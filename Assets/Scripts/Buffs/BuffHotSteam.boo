﻿import UnityEngine

class BuffHotSteam (Buff): 

	def Awake():
		self.label = "Hot Steam"
		self.affected_attributes = ["Block"]
		
	virtual def Effect(caller as string) as single:
		destroy = true
		return (char_controller.baseAttributes["HP"] cast single)
