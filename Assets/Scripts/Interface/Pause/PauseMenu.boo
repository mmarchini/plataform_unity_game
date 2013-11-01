﻿import UnityEngine

class PauseMenu(InterfaceElement): 
	
	DrawBox:
		get:
			return self.player.paused
	
	text as string:
		get:
			return """<color='black'>
HP: $(player.CurrentHP)/$(player.MaxHP)
MP: $(player.CurrentMP)/$(player.MaxMP)
ATK: $(player.ATK)
DEF: $(player.DEF)
Spear: $(player.Spear*100)%
Shield: $(player.Shield*100)%
CritChance: $(player.CritChance*100)%
CritDamage: $(player.CritDamage)x
</color>"""
	
	def Update():
		if Input.GetButtonDown("Pause"):
			self.player.paused = not self.player.paused
			Time.timeScale = Mathf.Abs(Mathf.Abs(Time.timeScale)-1)
		