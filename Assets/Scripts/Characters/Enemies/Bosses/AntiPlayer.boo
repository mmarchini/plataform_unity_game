import UnityEngine


class AntiPlayer(Boss): 

	public condition as string
	
	def OnDestroy():
		playergo = GameObject.FindGameObjectWithTag("Player")
		if playergo:
			player as Player = playergo.GetComponent("Player")
			if self.CurrentHP <= 0 and player:
				player.currentEXP += self.dropEXP
				
		ConditionalController.SatisfyClause("Kill$(Application.loadedLevelName)")
		if ConditionalController.IsConditionSatisfied(self.condition):
			Application.LoadLevel("Teleport")
		else:
			Application.LoadLevel("End1")
