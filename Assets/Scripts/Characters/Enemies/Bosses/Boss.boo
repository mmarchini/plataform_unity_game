import UnityEngine

class Boss(Enemy): 
	public afterDeath = "Teleport"
	
	def OnDestroy():
		super.OnDestroy()
		ConditionalController.SatisfyClause("Kill$(Application.loadedLevelName)")
		Application.LoadLevel(self.afterDeath)
