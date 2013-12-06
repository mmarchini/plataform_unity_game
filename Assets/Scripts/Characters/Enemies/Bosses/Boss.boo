import UnityEngine

class Boss(Enemy): 
	public afterDeath = "Teleport"
	def OnDestroy():
		super.OnDestroy()
		Application.LoadLevel(self.afterDeath)
