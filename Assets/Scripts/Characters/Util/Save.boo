import UnityEngine

class Save (ChangeScene): 
	
	def OnPlayerHit():
		player as Player = GameObject.FindGameObjectWithTag("Player").GetComponent(Player)
		player.LostHP = 0
		player.LostMP = 0
		super.OnPlayerHit()
		